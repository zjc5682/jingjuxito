# 梨园芳华 - 京剧文化平台

一个基于 JavaWeb 的京剧文化展示与管理平台，支持用户浏览京剧剧目、论坛交流、积分商城、内容投稿等功能。

## 技术栈

| 技术 | 版本 | 用途 |
|------|------|------|
| Java | 8+ | 后端语言 |
| Servlet | 3.1 | Web 框架 |
| JSP + JSTL | 2.3 | 页面渲染 |
| MySQL | 8.0 | 数据库 |
| C3P0 | 0.9.5.5 | 连接池 |
| Commons DBUtils | 1.7 | ORM 工具 |
| Bootstrap | 5.3 | 前端框架 |
| Material Symbols | - | 图标库 |
| Maven | 3.x | 构建工具 |
| Tomcat | 7 (插件) | Web 服务器 |

## 快速启动

### 方式一：一键启动（推荐）

1. 确保已安装 **JDK 8+** 和 **MySQL 8.0**
2. 启动 MySQL 服务
3. 右键 `启动项目.bat` → **以管理员身份运行**
4. 等待自动完成（首次运行会下载 Maven 依赖）
5. 浏览器访问 http://localhost:8080/

### 方式二：手动启动

```bash
# 1. 导入数据库
mysql -u root -p < jingju-db.sql

# 2. 进入项目目录
cd jingju-culture

# 3. 编译并启动
mvn clean compile tomcat7:run
```

### 方式三：IDEA 启动

1. 用 IDEA 打开 `jingju-culture` 文件夹
2. 等待 Maven 依赖下载完成
3. 运行 `mvn tomcat7:run` 或配置 Tomcat 插件
4. 访问 http://localhost:8080/

## 测试账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | `admin` | `123456` |
| 普通用户 | `user1` | `123456` |

## 功能模块

### 用户端

- **首页** - 轮播图展示热门剧目，快速导航入口
- **剧目浏览** - 按行当分类浏览京剧剧目，支持点赞
- **论坛交流** - 用户发帖讨论，管理员审核后展示
- **积分商城** - 注册送 100 积分，用积分兑换京剧周边
- **内容投稿** - 投稿京剧相关文章，管理员审核评优
- **个人中心** - 修改资料、头像上传、查看成长记录

### 管理端

- **用户管理** - 查看/编辑/删除用户，重置密码
- **剧目管理** - 增删改查京剧剧目，支持图片上传
- **论坛管理** - 审核帖子（通过/驳回/删除）
- **商品管理** - 管理积分商城商品，上下架
- **投稿审核** - 审核用户投稿，评优，添加评语
- **管理员申请** - 审批用户提交的管理员权限申请

## 数据库配置

编辑 `jingju-culture/src/main/resources/db.properties`：

```properties
driver=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/jingju-db?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf8
username=root
password=123456
```

## 项目结构

```
javaweb/
├── 启动项目.bat                    # 一键启动脚本
├── jingju-db.sql                   # 数据库脚本
├── README.md                       # 本文件
└── jingju-culture/                 # Maven 项目
    ├── pom.xml                     # 依赖配置
    └── src/main/
        ├── java/com/jingju/
        │   ├── entity/             # 实体类（7个）
        │   ├── dao/                # 数据访问层（6个）
        │   ├── servlet/            # 控制层（10个）
        │   └── util/               # 工具类（2个）
        ├── resources/
        │   ├── db.properties       # 数据库配置
        │   └── c3p0-config.xml     # 连接池配置
        └── webapp/
            ├── index.jsp           # 登录页
            ├── register.jsp        # 注册页
            ├── css/style.css       # 登录页样式
            ├── assets/css/         # 设计系统
            ├── img/                # 图片资源
            ├── admin/              # 管理端页面（12个JSP）
            │   ├── index.jsp       # 管理后台框架
            │   ├── css/admin.css   # 管理端样式
            │   └── ...             # 各功能页面
            └── user/               # 用户端页面（8个JSP）
```

## 数据库表结构

| 表名 | 说明 |
|------|------|
| `user` | 用户表（含管理员） |
| `opera` | 京剧剧目表 |
| `forum_post` | 论坛帖子表 |
| `forum_comment` | 帖子评论表 |
| `shop_goods` | 商城商品表 |
| `shop_order` | 兑换订单表 |
| `user_submit` | 用户投稿表 |
| `admin_apply` | 管理员申请表 |

## 常见问题

**Q: 端口 8080 被占用？**
A: 修改 `pom.xml` 中 `<port>8080</port>` 为其他端口

**Q: 数据库连接失败？**
A: 检查 MySQL 是否启动，`db.properties` 中的用户名密码是否正确

**Q: 依赖下载很慢？**
A: 首次运行需下载约 50MB 依赖，可在 Maven 的 `settings.xml` 中配置国内镜像

**Q: 中文乱码？**
A: 确保 MySQL 数据库使用 `utf8` 字符集，项目编码为 `UTF-8`

## 许可证

本项目为课程设计作品，仅供学习参考。
