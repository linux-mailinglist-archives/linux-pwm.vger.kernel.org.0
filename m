Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A752130AFD
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2020 01:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAFAsD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Jan 2020 19:48:03 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:8545
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgAFAsD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 5 Jan 2020 19:48:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keermweYljFTmLJVqU1Ik5J7b7Y8da9IXvv1iGgtunRtHXy7vgMQj+LcC2WH+5Lfnt4kJ5knFuD5wNi2h6ooNvpz/Y7bKeRyyna7/FRyFwcAZPCTTDSNGHWmE5rZz+3TiGN+dkum9tNk0Nzj0Qz0WD0qMnd9ARf5WmuP3H0YKctw39MrOTXKha7lEP8BJuW3sNTuBKdjWPGQorvBfGX9sepSiWMtqfwiJCAKP+qf0zg2TnFHoOBSpoMcg10bbgRAS4HrVnZe3L1MyBUj4kpwIJ/JnZp1M/KjkQckHGDrgzZc4hw46F56pJ8dGHtQAwoHVG8LRdylsBzP3YB5qFeJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d9FWqoIGsogvQv9SVWjm5ZUNjmrlhMRoLYd8HfHn1A=;
 b=h08r4SSlrwmxrUI0TzubBwEI7x7fzPNnwDyO/qrjmr+ZSsJWdMonYMZOXCo+bvWUv9lY9tswmcmZQej+kQ9FO8+8EvBs/NdmqoZO7lm12nnclgAm0fRfdnGBDfoOaTrQI7zaB4Qe/Bdub04BkOlGE59tdzgZp85oyPICyrc/SEiljevAYIYSjSjXL86xHLXQKrs/R79r01zKfzKB/HRI/Vq7qxG0SZrKa703kh/mw9jVqJzuNO4+fk6fEfYERP8neNIfK/qQwEqS+KSc0zuuoq8LFgJan9z1xAwJmbNaSuLskBdaZnepvwEGAC+ZlofPnp9oprbxRXPQNC8cUecZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d9FWqoIGsogvQv9SVWjm5ZUNjmrlhMRoLYd8HfHn1A=;
 b=Mmxb3jDr/N1Bz4M1lV7X2NEM4XtRdC7sKyMMYRT6NrBoouwZvSXCQl4/NB7GVLJ68cEWaKZyxbe99tJT0Bdxlt4BlT/aca/BRhX4Mx56AdUNeLqtUpTYUWjvkqDE1lzf58NaqqH0aK1AzBmVLtF2G+kfZKrsT0VuC7RVgGPgipc=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5629.namprd08.prod.outlook.com (20.178.6.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Mon, 6 Jan 2020 00:47:59 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 00:47:59 +0000
Received: from localhost.localdomain (136.49.227.119) by SN4PR0701CA0020.namprd07.prod.outlook.com (2603:10b6:803:28::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.13 via Frontend Transport; Mon, 6 Jan 2020 00:47:58 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v3 0/7] Add support for Azoteq IQS620A/621/622/624/625
Thread-Topic: [PATCH v3 0/7] Add support for Azoteq IQS620A/621/622/624/625
Thread-Index: AQHVxCrxACpBJ01+pUW4gR28mBigfg==
Date:   Mon, 6 Jan 2020 00:47:59 +0000
Message-ID: <1578271620-2159-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0020.namprd07.prod.outlook.com
 (2603:10b6:803:28::30) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a8d91c4-d755-44c7-c66d-08d792421394
x-ms-traffictypediagnostic: SN6PR08MB5629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB5629C5B3DB4EA60B386FC4D5D33C0@SN6PR08MB5629.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39830400003)(366004)(34096005)(189003)(199004)(7416002)(316002)(956004)(2616005)(6512007)(110136005)(69590400006)(81156014)(86362001)(81166006)(8676002)(508600001)(71200400001)(54906003)(6486002)(107886003)(8936002)(4326008)(2906002)(66946007)(66476007)(66446008)(64756008)(66556008)(16526019)(6506007)(52116002)(186003)(26005)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5629;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2KzUen7gJnXEDxk6iKaXSdNlr2EKcxy3GqH+wkClb/FOmTaUszNEiKBpSsrQ+hk2qFhuxMs+YVykhObL8MxE5URSb+iKEqiNw31kTg7LNXUm/w9WxXvYWTJ7FHrArbuCOC6GsjsSBZogGeOrUbyTf2Ah3jEz0UsEwQy+JcPzAFnFklVWZa7vth85rApOnUCJ8aQKEa/jGa95oyNwjyYNF5l9zO1RdJsWX1muo0EgLYn5UcBofP2lUZ//OW7qnDB599eYQT5Kh8S+FVW0Yrw6Y2MpdbQ5mvkne8ZiGsbKv925UYyHoSu2GprSG5dDVynd9Q8OGlaVyGt3GHgpVUs9j6EBylf99tul0ikioFBgUpHE1Dqp8HIfyTWTlzmAtWXTzKkWDHz3H+T01LKzx2m0w2VUXi130mrDdvbNCIJdMuBDO42JZf7QfloQTmOOg7k9s+DgjtcJ8a1CaWyefVgUeLDhD0VDk0IrRI+XA3qhVB2SeDzOK2qPrmP3k2/w9AB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8d91c4-d755-44c7-c66d-08d792421394
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 00:47:59.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efybgSs1v/7hbsMvPUvoMDNL5kZx6deDEfzJDdZ+GFBxSZb6gVY/K3PW5kc2dEN0WuyeYo+tzrXopek3g3WneA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5629
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds support for the Azoteq IQS620A, IQS621, IQS622, IQS624 and
IQS625 multi-function sensors. Each device integrates numerous sensing tech=
-
nologies in a single package.

A multi-function device (MFD) driver supports core functions common to all
devices, including device identification, firmware, interrupt handling and
runtime power management. The MFD driver is also responsible for adding all
product-specific sub-devices.

Each device supports self-capacitive, Hall-effect, and (in some cases) mutu=
al-
inductive sensing. These functions represent keys or switches and are suppo=
rted
by an input driver that covers all five devices. An assortment of pwm and i=
io
drivers supports device-specific functions including ambient light and angu=
lar
position sensing.

This series was tested using the following development hardware: IQS620AEV0=
4,
IQS621EV04, IQS622EV04 and IQS624/5EV04.

Jeff LaBundy (7):
  dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
  mfd: Add support for Azoteq IQS620A/621/622/624/625
  input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
  pwm: Add support for Azoteq IQS620A PWM generator
  iio: temperature: Add support for Azoteq IQS620AT temperature sensor
  iio: light: Add support for Azoteq IQS621/622 ambient light sensors
  iio: position: Add support for Azoteq IQS624/625 angle sensors

 .../devicetree/bindings/input/iqs62x-keys.yaml     | 132 +++++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 179 ++++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  32 ++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/iqs621-als.c                     | 614 +++++++++++++++++=
+++
 drivers/iio/position/Kconfig                       |  19 +
 drivers/iio/position/Makefile                      |   7 +
 drivers/iio/position/iqs624-pos.c                  | 284 +++++++++
 drivers/iio/temperature/Kconfig                    |  10 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/iqs620at-temp.c            |  97 ++++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/iqs62x-keys.c               | 340 +++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/iqs62x-core.c                          | 639 +++++++++++++++++=
++++
 drivers/mfd/iqs62x-tables.c                        | 438 ++++++++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-iqs620a.c                          | 254 ++++++++
 include/linux/mfd/iqs62x.h                         | 146 +++++
 25 files changed, 3243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yam=
l
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x-core.c
 create mode 100644 drivers/mfd/iqs62x-tables.c
 create mode 100644 drivers/pwm/pwm-iqs620a.c
 create mode 100644 include/linux/mfd/iqs62x.h

--
2.7.4

