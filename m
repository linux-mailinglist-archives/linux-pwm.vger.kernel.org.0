Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1918843D
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 13:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgCQMc7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 08:32:59 -0400
Received: from mail-db8eur05hn2245.outbound.protection.outlook.com ([52.101.150.245]:47210
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgCQMc7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 08:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzXD/0R76hSCunjkZEmBZEKV4iloYgPF8iUl/JqMoqoGrxFaNW55X9aKEkA+hturkWWIGRAsmKApPjZhhneZHbtNTZx6zGFTfu3w9QZphy2vd6Ggy6ieF8t2u2T095iLP5wSfLyRtoyc0pI0fXy8XGjmoQgASJTy5qDyHSvkW976LrGrfl6EEIl/qKTp1FkieDqR104/3dkZAF/qYeBLBS+BjLqoUCFKVxF6tSqfU2FGkFC1TQd3plqFJ2GlQAo9t0QKCuwuz9ReoCRduqO92OjJeUBWCONLjVrHyO+I7cqGmKQ0YxiZf6aIXpnuwiauPS3SxzFtfLOfelIXc331nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BUaJGJbqg0JUYFMqbF6EGhzBaFPZHK3eMENtXfOoy0=;
 b=bzEOmIat1tg04ihgTaOU58H9RNqnAlxUDaBdLDrG63+G3lC+iiaV+iJ8CXpBgRgjWS9yX59+aEIk7sL6bwo56T2oBAp6G5PQYvlZ/T1C6rhLLpwCRHQQ0cRHLXIuf1TTNPYUxkIAGwecpQnj9k3g0twUDkKeF4Zjm6rmhxUIvtvg2KI4FY6OXMQEzIT24Z+vQ5HYUuFJXvUYVD2+tBrVDeaNDlWqWu3qhXWBHS+rZ6zeIJepmKGO4GuZUPLa87E0f3jaqF31JXxDQbbizdzNAS5qnBb1lO8mMRuwF/bEfG+qks9eS8IvXWg18udGs3OGlss3b/PNpeHOPMM5pgC5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BUaJGJbqg0JUYFMqbF6EGhzBaFPZHK3eMENtXfOoy0=;
 b=LRVFsNakT8OqOokKccD19UcN3aFnGY5rj+vD896nyGCDZyDr3iJU8xKwOrq+LqsvPWLoUxdpxCJFcMOr+wzRhy8F19jpSxajbA2GdJHKqlLMq/uI5IaQof9Shto1LbSDtS2IMedaeS/cpOIQpu3ZqGnkSbg4HHvBBXKThxKbg1M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (10.171.182.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 12:32:44 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 12:32:44 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Paul Barker <pbarker@konsulko.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Date:   Tue, 17 Mar 2020 14:32:26 +0200
Message-Id: <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0228.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::24) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by PR0P264CA0228.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 12:32:44 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc38745-91a6-415b-2077-08d7ca6f4aea
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:|VI1PR05MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462C32670784CA6022AE2FAF9F60@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(199004)(66946007)(6666004)(66476007)(66556008)(5660300002)(36756003)(4744005)(1076003)(4326008)(26005)(6496006)(44832011)(52116002)(54906003)(81166006)(81156014)(2906002)(8676002)(55236004)(316002)(186003)(8936002)(956004)(478600001)(2616005)(6486002)(86362001)(16526019)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB4462;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3GKWNRuLvnd8Vj+VVKGL8hCfvyf1ES8trTnmv1OQjyOE5F47Z4vyK4kn6uPekK+HSu9RvVEe8213hbDdxlI1DoH050TLtIhow7fxl/0dd7//pAkKK++HJQSdphoouIIUPf3339F/l0nsccHfjypKRCiV8m/Rm8B2V8IjfjwJ0/r8boXgDQrH6wuox/wm1JgOC0wiiy3Spzbt7BE+zXdpvd8zu9JJbi5NUCO/7v6rxb3ojFU3qzBxW+pkepeGvo16AAwu2e8bryTsO3GJQ+t+Rx3ZLcTGAouQQtOnc10tD0mUE8uhxjHhb0+It8BfwJ2WV6vCItOSqQi1uiqECYPFjlAwC5TwBhYUxkvDIPvzCD2sAoh6KUTF3jkh4qvWfamdWfmVLPtYWxY95W+1QLuiZpsFogklwENZRWk25sQr7OIIqfyoqdzRuWvzHyB9Huyt8EcMH9I0btfHXHIdd7xNCNiaNL3NLEATtLBak+7t3w0vfQYcBcAl4aVINvDB7btdvu66iERLEM1TnIEF9OsIc0rQelAz9oRDaxlu3Gw6hav0pOIx5AbUKvWGId5hpy+XIIF0IHRvhyk/pKE2y8I0+C2MMlhfktH1dCjCv3ffxQEUoOeUT/jPjZDb/B8mYRgHuj90ZMMRifnwSrP/jBADLrdgjbdScBxfla5LmBdMTEi+gEMnq4pwLxxTQ6TVl3nx45Sdfrj2RZbi12VwuHV+/JkL3rQ/xD/+CxT28NHlpBMnUhayUjOREBwTjYjt+CMaZjZ9JHSCxf5I/rQEKUPOw==
X-MS-Exchange-AntiSpam-MessageData: z80Od//QHvH2uLgtIT9E0ovuaLuntY27J1TM4VttQl4n4nXMkhn2k5xRP8cRosbcHxKQN94fnU5BuFO3PyAemA7HIiR2gQDBF7NuvSHyZGDCyFpLaFCRQtRs4N9fKhsKh0LGf7tCOFO+FmZTQ0MoAw==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc38745-91a6-415b-2077-08d7ca6f4aea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:32:44.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR46RlDZXp3sgSae5/nu+miavoN7w7wnSOCv6ko2RJ6t/GzTNlSc7VRg3QOcGcqaMYDeYiyvQI3x9VLZs/hLVqWlq3bUl9ym2HpUmVdGqKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the description of PWM_POLARITY_NORMAL flag.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 084886bd721e..440c6b9a6a4e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -46,6 +46,7 @@ period in nanoseconds.
 Optionally, the pwm-specifier can encode a number of flags (defined in
 <dt-bindings/pwm/pwm.h>) in a third cell:
 - PWM_POLARITY_INVERTED: invert the PWM signal polarity
+- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
 
 Example with optional PWM specifier for inverse polarity
 
-- 
2.24.1

