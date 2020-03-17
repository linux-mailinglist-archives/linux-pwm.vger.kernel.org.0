Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525F818844D
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 13:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCQMdD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 08:33:03 -0400
Received: from mail-bgr052101134067.outbound.protection.outlook.com ([52.101.134.67]:55685
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgCQMdC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 08:33:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfHRtcyD0pcOfGdc8jz+WxLx2oLETgxwUo++AffG45ExW9srB+K5IoAaDbNDbU5Ic7YbvDHhM3uQFSa2uJsdc6+QO9arf7OYxiakk3NLML4VRfVDwhEuGHHU4kgFFgIhBpbweZ6VGeStiLeKyL0IJ0NROiM+mTXTQcJJLzeE44HJHw28NY1ebBxNIIPbvh/YPeBiaSwsFEod8gJQfFI/1blFNeign8aTw7e1pqaIkNANBpBZ/cxnvmWoEUTC031GK9TVwhkdqWGUVg6wavZszfeO7Gad8hdcZBeq3SYTY2EANb/Ru1jEQpccNSHdGp9OUGSIeVNreZJuz8V8OzQLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSKPX3WA2z0UVrR9lE4EXwYA+AzLoYnV3FLQ1FADj5M=;
 b=HcPiKW/db37oNsH0n6oqSoysvGgp8KjglnhAkyt7qtRskIkoBlHEVAL0Ak+MwqQDbaGWysrwNqknPndlPE/LU3jNfKI04LWSpMBebhGwoj38MjXd80HMhXkGobUR7GgYv1ksCdRM04UnHujc59tCU4cjBPtoWyXaytCfdGO2UW6hYJrT041xW46zq/yBMNQV4V5vAs5Nx6pUtL1+q4qA/g21acDtVUS/w6FHLgMhlxam0WSmzlCAqXRC4oyb/Wb1Alqh9efb4Mp5YWeRWtz5ikYvHkDi3aOmz53N3DRzqygSa4XMXa1LJAO0iN+Q8T8/JLj+Motse9Qv0jAMrjRnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSKPX3WA2z0UVrR9lE4EXwYA+AzLoYnV3FLQ1FADj5M=;
 b=RnMfkEDSd4CdJ3VUbaAiVsEnNe8WCblYK42LQOaanCBAJlEVKNb2wuJ676KhG2mEUm8rh6E4QRZIIoOZ1pwjL1tQMlRiySgG4v4wT+D05rz82vmO4ryI50SJzkJLzYSnpP/QR+2/jiJHUPkRvZs10yK7COirRNIONZ+eO/WE8JA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (10.171.182.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 12:32:49 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 12:32:49 +0000
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
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] dt-bindings: pwm: add description of PWM polarity
Date:   Tue, 17 Mar 2020 14:32:28 +0200
Message-Id: <20200317123231.2843297-5-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::17) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by PR0P264CA0053.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Tue, 17 Mar 2020 12:32:49 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5f0782c-b0fa-41e8-f045-08d7ca6f4ded
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:|VI1PR05MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462D6759FFFCF1CFF6900E9F9F60@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(199004)(66946007)(6666004)(66476007)(66556008)(5660300002)(36756003)(4744005)(1076003)(4326008)(26005)(6496006)(44832011)(52116002)(54906003)(81166006)(81156014)(2906002)(8676002)(55236004)(316002)(186003)(8936002)(956004)(478600001)(2616005)(6486002)(86362001)(16526019)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB4462;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haE+S+lJ55nKwps8azUmHcseB5BDF7itGM9rdMJRNM8ahbrLY0YGGneg8bccM5B5YcIkSp6nAF7HkdXBLmUo0ZnqdaRdpkVqaAqMM+rG+vtGP4UzHY0rE0W3IMFwyGrqlxw6Gi+7ae898lyLpwtOxgT+cmV6lcgiMJNhAk/KOAzPvqJH/V6AGmS3NLvNHG93+4swtebU+IXDolvgTg/owOFJJJDnPTH1ab6V12qfGPCufNpyIT7aTm4kJIFoUrCtV40r5ba7uxhRgYb/V7NUv9kAtDId3wfVrqN3p4cAX0sTEoYTUX96fNgfIyutJAA1mVCuvZt+pHBqmBWycPV8iEx4q2wjAvIcJXdVglhsYtoC6clemlm5umsm1tEoxdDxzLTsgnFkH3ZCDHOkl7yr0C2SErTvOeuQcHt0T7Rol1r2N7ip7gvzuemYifQUy2dw2cQcHpqbnUoq/ydRpvrBIdPkjc3Sc8PHHGoJ6BfzTaaPD9QkL5Q2Hf9pCd67Af4Emt0a41pZeOV61PITwib822UT/hVNk5MXtFO8MgJmzJpqR6zVGXkHW6xI2PwaNy82yEQJx1U/G0x4/Tb2LwdYpGqplBXRZIPMKe92DTb4Ii2UXOTXbqP3/Tqi8qhu99DVCTQUSf9INE5BKXSCh/dRbtWtwECpEFgGomZl9TQu5aXJxxexgzL0PPF/JPiRJkaubdw3hHxMiHmT80yUkNdNrudb3LsoQYUdoO81TlnwPxD3sMUjrsEIASAlysLsjpZeBknTqi23tKpZZEDLi6MyMw==
X-MS-Exchange-AntiSpam-MessageData: zREJ4bF+lHJEUHNcRQWeti2/tkinrA3V/cSwNOH1Sphg2QrZPVhYD+ew7Bo527yUojsoUhHjMKCjESsm2ifgxufJJL5Q7AKtCAXLsr2ZmRdSyKm/3BUsOCxtLWJggUxjFguh2+oxVjNfypq3pa0ViQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f0782c-b0fa-41e8-f045-08d7ca6f4ded
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:32:49.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8ucM0nXfrI/WPmlyqbtWAqA+jAR3B1/Naah3qDzs7jYm5i3zv9CrKM5qq3Qj6frDh2WcXK3hxm44mDIPjaHI1CCVBg+4uwhO96j10e3lGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Move the description of the PWM signal polarity from
<linux/pwm.h>, prepare for removing the polarity
definition from <linux/pwm.h>.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 include/dt-bindings/pwm/pwm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index 6b58caa6385e..c07da2088a61 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -10,7 +10,16 @@
 #ifndef _DT_BINDINGS_PWM_PWM_H
 #define _DT_BINDINGS_PWM_PWM_H
 
+/**
+ * a high signal for the duration of the duty-cycle, followed by a low signal
+ * for the remainder of the pulse period.
+ */
 #define PWM_POLARITY_NORMAL			0
+
+/**
+ * a low signal for the duration of the duty-cycle, followed by a high signal
+ * for the remainder of the pulse period.
+ */
 #define PWM_POLARITY_INVERTED			(1 << 0)
 
 #endif
-- 
2.24.1

