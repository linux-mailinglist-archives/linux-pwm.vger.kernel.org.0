Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D33160736
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2020 00:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgBPXch (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Feb 2020 18:32:37 -0500
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:6137
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbgBPXch (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 Feb 2020 18:32:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G77UadDxg9qtMAchnlCrLmAqnGKzznMaTnW6uC06Yorzq+zRZSY2c+BMOka/fxWeTyafHMHoyJ1n1njhhbqClfS57rYHpMkt+8x8/LVMa/zonvNhIjIevNm2ZDjrUPednPZSBWES9SAai2D/vNYr2aFg7G5LOAI244YWketWgrskmRNGeEAzG3vvWYTAjCf8hIIbSCdj0wXp1gNCevv4cd10eY8Ge/K1r6mDT6gMLSgPqaKyUwQCLVeMHPpulwOH851zKzzEppOZh39lbq3hhiyi6xIyAlFmr1wq21wufstIWfjAyzMaZfIf3acOZePDSr884SSw0mdx/SXxAWYKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UfjynYxKuTgJagCRQyzEnaPhEHLym0Xa4nwrQIvo8I=;
 b=iwiAOkEn49ioSc2+58uEMtZrObL8Xgm57snIDfzKAp9+uVKhjGqLXfXVCAGhrnWo1XaZk5tAnMCmOPIhmhHctexIsKyUl1eWWXEoPLVR2BoIkVlvb1CkhPciSj4lN3CpS5Tr5JBJpkKVz0jpglEKfh0H7zpDrf2P/J8eNGj8yPiPiMMcmETrvIaqfe8oMZOeGHTfQx5BPyyIZQhtQk49mrjmtBOjjPlr8CfEFY52S9hhgfQxsQO1mWs0EmGoGiKTXTBPnZmWP/LmoGj9MqXktCQOqPumf7pHy2PYFgeR+MdcUaVU0/iXBWqH6eVp5sJxxx6Kz9G7WyUQPZeZU1YLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UfjynYxKuTgJagCRQyzEnaPhEHLym0Xa4nwrQIvo8I=;
 b=igqEkzfJDqjTKJZyaXchZPj0jSYrPsx8mdgbZnTuaab55QNjz/dN2NZG8HHVyvk28pSGpOpOM+wqBNcLTKx5OydXtP4HtcyrzR6zCMJLtC/XwK0CsWe61uOmi16oS4utpMAZ2ZB1cck34SQmEhv9KMefnzCchppA6SQiT/4iTUE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5406.namprd08.prod.outlook.com (52.135.117.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Sun, 16 Feb 2020 23:32:32 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945%4]) with mapi id 15.20.2729.025; Sun, 16 Feb 2020
 23:32:32 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v5 0/7] Add support for Azoteq IQS620A/621/622/624/625
Date:   Sun, 16 Feb 2020 17:32:04 -0600
Message-Id: <1581895931-6056-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
MIME-Version: 1.0
Received: from localhost.localdomain (136.49.227.119) by SN4PR0501CA0142.namprd05.prod.outlook.com (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.9 via Frontend Transport; Sun, 16 Feb 2020 23:32:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ff220b1-2cdb-4df4-05e7-08d7b3387ee8
X-MS-TrafficTypeDiagnostic: SN6PR08MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB540639144DE816F8A169C5F0D3170@SN6PR08MB5406.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39830400003)(396003)(376002)(199004)(189003)(8676002)(107886003)(8936002)(4326008)(7416002)(69590400006)(956004)(66556008)(2616005)(81156014)(81166006)(16526019)(26005)(5660300002)(6506007)(186003)(66946007)(6666004)(66476007)(316002)(6486002)(36756003)(52116002)(508600001)(966005)(6512007)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5406;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFJj+48jFeucJ/A85JIcRmZARtF88gQ81E4B7oZdz+G+tduKz3snfU3JIHsrl/V/jurZ6O7IZUj50+EpPGKqXfg4Bpm6wfQbHA7HWqzdPLVrpZqqIt099f1z9erECsKTVxZU2Lao96algHrrC/IEVaJHYEpaTUtkwMHvHZp/ePqOPI+58T0LxWujN9RDolEJ35XSsNq8l2yFnuYQ4+otIhVk0EmMLAu3VDM8O0wq3ZscfAQfdN2LdaYiujorNERiDJ4bjjF7jH9C5uf9jJpCNnjHYa/FqCS/ptEmwA9kK/htZAM2/pbPA63to8Q1ET/moob1ZbhGzHLcIxP3Sq6bi1sQi/atGzz9xO6IgQlWNbIA8BCKSWC71VtsaHujyVkpgVWytjxl2J7jCw9yh4FgXM1O9iLwZ2L+WlN8I15cMpMWXNz1oPl7rZahows4AaDJBc1cGmpcehp9jMwaR84xPL4tTwLq37C477soLMOpGuQVcUIMgAx1JlN5HtWrXG4wK/kgEXaVpAYy1O1gNfNnapdrymzQQYTl8ObIN0r5m5ksrS4bsX8YhafRI7yT5EizYd9EZ0NZHEhwj/57ylznw1dVa8LvMI/T3e/oE6zIB5+wPHZG0ebmIreCV2t6k9OB
X-MS-Exchange-AntiSpam-MessageData: FyYJTHyF5LR5SCso9z07JghZyoiTEv0Py5aigY1Xic34U16iK+jyWlLUOeWwteQhWEC9G+9TSxEJ7nxvcah0/HDC+mXj5xnO2BBf47nEgNTW9V4ad7xsaCgvWzQGED9YXCW2MjNRO/dKpRmyREBhtw==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff220b1-2cdb-4df4-05e7-08d7b3387ee8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 23:32:32.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjQzLjIp1OdmewBp7/9dfi2n9llU0O9l5ErwZVGMh4w1YD2e9t+XnoHK2mjXIK8OjxdmmC8NLhuvNMjhefYR5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5406
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds support for the Azoteq IQS620A, IQS621, IQS622, IQS624 and
IQS625 multi-function sensors. Each device integrates numerous sensing tech-
nologies in a single package.

A multi-function device (MFD) driver supports core functions common to all
devices, including device identification, firmware, interrupt handling and
runtime power management. The MFD driver is also responsible for adding all
product-specific sub-devices.

Each device supports self-capacitive, Hall-effect, and (in some cases) mutual-
inductive sensing. These functions represent keys or switches and are supported
by an input driver that covers all five devices. An assortment of pwm and iio
drivers supports device-specific functions including ambient light and angular
position sensing.

This series was tested using the following development hardware: IQS620AEV04,
IQS621EV04, IQS622EV04 and IQS624/5EV04. A demonstration of the series can be
seen at the following link: https://youtu.be/7hJZPeFT0aY

Jeff LaBundy (7):
  dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
  mfd: Add support for Azoteq IQS620A/621/622/624/625
  input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
  pwm: Add support for Azoteq IQS620A PWM generator
  iio: temperature: Add support for Azoteq IQS620AT temperature sensor
  iio: light: Add support for Azoteq IQS621/622 ambient light sensors
  iio: position: Add support for Azoteq IQS624/625 angle sensors

 .../devicetree/bindings/input/iqs62x-keys.yaml     |  132 +++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  |  179 ++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |   32 +
 drivers/iio/Kconfig                                |    1 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/iqs621-als.c                     |  617 ++++++++++++
 drivers/iio/position/Kconfig                       |   19 +
 drivers/iio/position/Makefile                      |    7 +
 drivers/iio/position/iqs624-pos.c                  |  284 ++++++
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/iqs620at-temp.c            |   97 ++
 drivers/input/keyboard/Kconfig                     |   10 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/iqs62x-keys.c               |  335 ++++++
 drivers/mfd/Kconfig                                |   13 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/iqs62x.c                               | 1063 ++++++++++++++++++++
 drivers/pwm/Kconfig                                |   10 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-iqs620a.c                          |  270 +++++
 include/linux/mfd/iqs62x.h                         |  139 +++
 24 files changed, 3234 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x.c
 create mode 100644 drivers/pwm/pwm-iqs620a.c
 create mode 100644 include/linux/mfd/iqs62x.h

--
2.7.4

