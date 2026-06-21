// 京剧文化平台（梨园芳华）自动化测试脚本
// 运行方式: npx playwright test test/auto-test.spec.js
const { test, expect } = require('@playwright/test');

const BASE_URL = 'http://localhost:8080';
const TEST_USER = 'testuser_' + Date.now();
const TEST_PWD = 'Test@2026';

// ===== 注册模块 =====
test.describe('用户注册', () => {
  test('R-01 正常注册', async ({ page }) => {
    await page.goto(`${BASE_URL}/register.jsp`);
    await page.getByPlaceholder('请输入用户名（4-20位）').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码（至少6位）').fill(TEST_PWD);
    await page.getByPlaceholder('请再次输入密码').fill(TEST_PWD);
    await page.getByPlaceholder('请输入手机号').fill('13900001234');
    await page.getByRole('button', { name: '立即注册' }).click();
    await expect(page).toHaveTitle(/登录/);
    await expect(page.locator('body')).toContainText('注册成功');
  });

  test('R-02 用户名已存在', async ({ page }) => {
    await page.goto(`${BASE_URL}/register.jsp`);
    await page.getByPlaceholder('请输入用户名（4-20位）').fill('user1');
    await page.getByPlaceholder('请输入密码（至少6位）').fill('123456');
    await page.getByPlaceholder('请再次输入密码').fill('123456');
    await page.getByRole('button', { name: '立即注册' }).click();
    await expect(page.locator('body')).toContainText('已存在');
  });
});

// ===== 登录模块 =====
test.describe('用户登录', () => {
  test('L-01 普通用户登录', async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill(TEST_PWD);
    await page.getByRole('button', { name: '登 录' }).click();
    await expect(page).toHaveTitle(/首页/);
    await expect(page.locator('body')).toContainText('梨园芳华');
  });

  test('L-02 管理员登录', async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill('admin');
    await page.getByPlaceholder('请输入密码').fill('123456');
    await page.getByRole('button', { name: '登 录' }).click();
    await expect(page).toHaveTitle(/管理员后台/);
  });

  test('L-03 密码错误', async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill('wrongpwd');
    await page.getByRole('button', { name: '登 录' }).click();
    await expect(page.locator('body')).toContainText('错误');
  });
});

// ===== 首页模块 =====
test.describe('首页', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill(TEST_PWD);
    await page.getByRole('button', { name: '登 录' }).click();
    await expect(page).toHaveTitle(/首页/);
  });

  test('H-01 轮播图显示', async ({ page }) => {
    await expect(page.locator('.carousel-slide').first()).toBeVisible();
    await expect(page.locator('.carousel-slide.active')).toHaveCount(1);
  });

  test('H-02 排行榜显示', async ({ page }) => {
    await expect(page.locator('.rank-item')).toHaveCount(4);
    await expect(page.locator('.rank-item.active')).toHaveCount(1);
  });

  test('H-03 推荐剧目显示', async ({ page }) => {
    await expect(page.locator('.opera-card')).toHaveCount(4);
  });

  test('H-04 轮播图左右切换', async ({ page }) => {
    const firstSlide = page.locator('.carousel-slide.active');
    await page.locator('.carousel-btn.next').click();
    await page.waitForTimeout(700);
    await expect(page.locator('.carousel-slide.active')).not.toHaveAttribute('data-index', '0');
  });

  test('H-05 排行榜联动', async ({ page }) => {
    await page.locator('.rank-item').nth(1).click();
    await page.waitForTimeout(700);
    await expect(page.locator('.carousel-slide.active')).toHaveAttribute('data-index', '1');
    await expect(page.locator('.rank-item.active')).toHaveAttribute('data-index', '1');
  });
});

// ===== 京剧剧目模块 =====
test.describe('京剧剧目', () => {
  test('O-01 剧目列表', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserOperaServlet?method=list`);
    await expect(page).toHaveTitle(/京剧剧目/);
    await expect(page.locator('.opera-card')).not.toHaveCount(0);
  });

  test('O-02 点赞功能', async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill(TEST_PWD);
    await page.getByRole('button', { name: '登 录' }).click();
    const praiseBtn = page.locator('.praise-btn').first();
    await praiseBtn.click();
    await expect(praiseBtn).toBeVisible();
  });
});

// ===== 论坛模块 =====
test.describe('戏曲论坛', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill(TEST_PWD);
    await page.getByRole('button', { name: '登 录' }).click();
  });

  test('F-01 帖子列表', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserForumServlet?method=list`);
    await expect(page).toHaveTitle(/戏曲论坛/);
  });

  test('F-02 发布帖子', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserForumServlet?method=list`);
    await page.getByPlaceholder('请输入帖子标题').fill('自动化测试帖子');
    await page.getByPlaceholder('分享你的戏曲心得').fill('这是自动化测试内容，验证论坛发帖功能。');
    await page.getByRole('button', { name: '发布帖子' }).click();
    await expect(page.locator('body')).toContainText('成功');
  });
});

// ===== 积分商城模块 =====
test.describe('积分商城', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill(TEST_PWD);
    await page.getByRole('button', { name: '登 录' }).click();
  });

  test('S-01 商品列表', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserShopServlet?method=list`);
    await expect(page).toHaveTitle(/积分商城/);
    await expect(page.locator('body')).toContainText('当前积分');
  });

  test('S-02 积分余额显示', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserShopServlet?method=list`);
    await expect(page.locator('body')).toContainText('100');
  });
});

// ===== 作品投稿模块 =====
test.describe('作品投稿', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill(TEST_PWD);
    await page.getByRole('button', { name: '登 录' }).click();
  });

  test('T-01 提交作品', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserSubmitServlet?method=toSubmit`);
    await expect(page).toHaveTitle(/作品投稿/);
  });
});

// ===== 个人中心模块 =====
test.describe('个人中心', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill(TEST_USER);
    await page.getByPlaceholder('请输入密码').fill(TEST_PWD);
    await page.getByRole('button', { name: '登 录' }).click();
  });

  test('P-01 查看个人资料', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserPersonalServlet?method=toPersonal`);
    await expect(page).toHaveTitle(/个人中心/);
    await expect(page.locator('body')).toContainText(TEST_USER);
    await expect(page.locator('body')).toContainText('100 积分');
  });

  test('P-02 编辑资料', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserPersonalServlet?method=toPersonal`);
    await page.getByRole('button', { name: '编辑资料' }).click();
    await expect(page.locator('body')).toContainText('编辑个人资料');
  });

  test('P-03 修改密码', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserPersonalServlet?method=toPersonal`);
    await page.getByRole('button', { name: '修改密码' }).click();
    await expect(page.locator('body')).toContainText('修改密码');
  });

  test('P-04 申请成为管理员', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserPersonalServlet?method=toPersonal`);
    const applyBtn = page.getByRole('link', { name: '申请成为管理员' });
    if (await applyBtn.isVisible()) {
      await applyBtn.click();
      await expect(page).toHaveTitle(/个人中心/);
    }
  });

  test('P-05 退出登录', async ({ page }) => {
    await page.goto(`${BASE_URL}/user/UserPersonalServlet?method=toPersonal`);
    await expect(page.locator('body')).toContainText('退出登录');
  });
});

// ===== 管理后台模块 =====
test.describe('管理后台', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(`${BASE_URL}/index.jsp`);
    await page.getByPlaceholder('请输入用户名').fill('admin');
    await page.getByPlaceholder('请输入密码').fill('123456');
    await page.getByRole('button', { name: '登 录' }).click();
    await expect(page).toHaveTitle(/管理员后台/);
  });

  test('AU-01 用户管理', async ({ page }) => {
    await page.goto(`${BASE_URL}/admin/AdminUserServlet?method=list`);
    await expect(page.locator('body')).toContainText('用户管理');
  });

  test('AO-01 剧目管理', async ({ page }) => {
    await page.goto(`${BASE_URL}/admin/AdminOperaServlet?method=list`);
    await expect(page.locator('body')).toContainText('剧目管理');
  });

  test('AF-01 论坛管理', async ({ page }) => {
    await page.goto(`${BASE_URL}/admin/AdminForumServlet?method=list`);
    await expect(page.locator('body')).toContainText('论坛管理');
  });

  test('AG-01 商品管理', async ({ page }) => {
    await page.goto(`${BASE_URL}/admin/AdminShopServlet?method=list`);
    await expect(page.locator('body')).toContainText('商品管理');
  });

  test('AS-01 投稿审核', async ({ page }) => {
    await page.goto(`${BASE_URL}/admin/AdminSubmitServlet?method=list`);
    await expect(page.locator('body')).toContainText('投稿审核');
  });

  test('AA-01 管理员申请审核', async ({ page }) => {
    await page.goto(`${BASE_URL}/admin/AdminApplyServlet?method=list`);
    await expect(page.locator('body')).toContainText('管理员申请');
  });
});
