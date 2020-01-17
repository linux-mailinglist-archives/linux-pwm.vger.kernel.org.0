Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976621401F1
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 03:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388969AbgAQCfV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jan 2020 21:35:21 -0500
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:6188
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729113AbgAQCfV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Jan 2020 21:35:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePelwc/DIRGnZcOi1gxIixKyRyrYqCXDjITIob5ymGAWTPQsAssLuIBZlCX2V+uQWdAZCcr52RLO8SNEFhrESY6FbmUPMGplr9SjkYqkSLI7/+RbnUZ3jdvJvlQOrZUoZXVEeSuCENbYWvpu7g6Jql+aH7zikJzeSNMrwbs9DhNNgKRBS0ipAibER8/62UyVK9XagXSv6dONzRiguWqR927qSb4fWkpl/habkDMs/ElGluu6GXtZ3qDXc/OjKVaKHRZ5f+xdi3cnJ/A/LB7Y8nWo5f9GWsiv3y1i6bmYk5tojtEvHh3tkeVlXM5y7j81dz0saJzVHaN2oIt4CsZBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwO+8/jyIJXNnzpn/zI9FQHdsNfrhez2aV2FaP1T+AM=;
 b=Pf7zn01VCU0NR6kMyIWQ0UoFK6i7Y0lRDfUYYxvyF5r7h9H5QyrjWkRyNg4mM+UsCQzp6zfP9HGVRwfphTe6o1nfAOtVS30YTpLUNo2N3ezDsaSKHFsPFQUjmWZLO8woG4UqA4Qde6CE3JDu5+gEYzt2nNKaoGY8a0EP9Hqm4UxzjrUG0YIk6aAmIdR0SOLLNI7+gCvJF00Z1xk8S2eAZJG+J3tmORcvwP+1wPXVpLJtF92a55DaGvVRJj0vU/9w725tv7GoHgwDU4V+DWLl0D2MN1Zjt3zlmOz9LYmZCfd/x494jUf99/B+XNnaLkwJRE1I0hV0arXhMtd0gUMO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwO+8/jyIJXNnzpn/zI9FQHdsNfrhez2aV2FaP1T+AM=;
 b=jbXIennWtZCj+5/QVdM1ZNnseIcuTtMkoe0llXL8QkxUh8VNpLsSgRHMczJ/2+EOU3qiAkCA42KkCel6ihfaurLQkQ3KUDAVxxG+Km/uD7+yA5CYpUT79OAEHiup0yOvt012usSvp3yM38m6MI2zLmY1P72rK4fTRtOfo58NMvA=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB6029.namprd08.prod.outlook.com (20.178.6.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Fri, 17 Jan 2020 02:35:17 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 02:35:17 +0000
Received: from localhost.localdomain (136.49.227.119) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Fri, 17 Jan 2020 02:35:07 +0000
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
Subject: [PATCH v4 0/7] Add support for Azoteq IQS620A/621/622/624/625
Thread-Topic: [PATCH v4 0/7] Add support for Azoteq IQS620A/621/622/624/625
Thread-Index: AQHVzN7AiHhOY9JL506kbCakEUdXpA==
Date:   Fri, 17 Jan 2020 02:35:16 +0000
Message-ID: <1579228475-6681-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00592a24-5966-4c4f-9098-08d79af5e30e
x-ms-traffictypediagnostic: SN6PR08MB6029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB60297EC18FBDB2B92532E514D3310@SN6PR08MB6029.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39830400003)(396003)(376002)(34096005)(366004)(189003)(199004)(36756003)(66556008)(107886003)(66946007)(4326008)(64756008)(66476007)(956004)(54906003)(52116002)(6666004)(110136005)(66446008)(2616005)(6506007)(69590400006)(86362001)(26005)(316002)(16526019)(186003)(81166006)(2906002)(6486002)(8676002)(81156014)(508600001)(5660300002)(71200400001)(7416002)(8936002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB6029;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQG4WWOVQDmcDg5nrACbDEF1XYukPo0lDAKmxGWwlLoaFlFCcQCaYo0WIH0uHCtwxuCZ9NzrECyLTTGkAYFntvuNb8AG9OZjhZrh4oKUKLT21Vu77d0C0ZrAI/6uKIB1KMBXCLGw/ALivaoGQnYEzal1Y/0bmDp0A1towb7RbTtra9jns7VMLCSWPMFbXiDumL0f5sHFiB4v3KQdlKRhg5lJU8hsfj6Zpczj74tgMjtRzQ9Lz2N0uLwTsS0DVJ+6RkD1Z4qd+mLlzeBkqIwNDgljHRVvLQZQvdH7Xf7IQjvsCYoUhsN4lVzfppqWTgTfOxdY/H0eRjWtEFekThNz7z4Hf28Bh7GjosX+Z15t8XUdFMrym/g1rsqzra6wzIErinOmN8OvyHx+pcgtxYg+Kg2QxPhbWf4JQqJS/rkvwN86479Mei7Ya42xShRpD3aYaXbnZJGya1xnqktue4NEuZTsyQ9UF3zuMDh8UV1Dyyo41pZ5nv0mhVsGUS0lIUj9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00592a24-5966-4c4f-9098-08d79af5e30e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:35:16.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRqxkT0h7SaszMJwPYCyR+pXpK8SSssnB347Z5Ahwwhu9KU8dONHsYDpySRHEJbRw1s1uC7+pVNWrgYUTArQZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB6029
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
 drivers/pwm/pwm-iqs620a.c                          | 258 +++++++++
 include/linux/mfd/iqs62x.h                         | 146 +++++
 25 files changed, 3247 insertions(+)
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

