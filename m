Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20809188440
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 13:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgCQMdE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 08:33:04 -0400
Received: from mail-bgr052101129028.outbound.protection.outlook.com ([52.101.129.28]:58341
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgCQMdD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 08:33:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtwkPNuMuTCIjqSOXDldQuWM863KqEUv2REKbXKS9OG3vdvKJUKZAZW/OLdX/L83qWFJ63vG8jS+M5KTctfE7HYL54hZfmZ2XZCS9XE1q976KQitIAFx/Lp/0dGLllJBrgSOZDVFxBLJc5g9idxjjmHCG5EXO+bZcsxTpuQPts9udWf5hPcfOmWMHtTLv2Z437KUmQt7oPnkm2JIQXjFn++tao5O6lwevUb/ZuAz5wZ43y+xc8UZsyFVCbgiJTtwLexkRAJvphBiHzxWnuT0Rc9sTrY8aaIBJLIyDSaH/t7rV5FV6z49aHYwoQnng361RKka9MUrDCHZkC/jJg2YPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsLsIYOxL6tnTsz3E4z7cH5f129GFaUqTBlODvsByOo=;
 b=ec4WhZX0yyr4CVZLZWhaJDmq8poYx4wjNEgFxuh6U1nFJkyQy3A3ZHmzUehU62JCzCJ8DhXceGhOpCsCkSx7xw9y7SkmOYqjMzshy6szGcwulXlBkuzXguKkR0qXMPTQ2t46F4fkhTPgPSTvixt0MKedBbntqimXHroe19XwTx16u+AM/QdhKColUejE+Dtv3650p5G62VY0RF+vEXJ15WDjX1AYBPqt90cg8ocLdO8AfSGPpIqpRinZJ2PRQujEwQpZaPbqJAoN7LpH6++mpz/72DTcLjfhCPiiD5MbYjuEaBbPzM0DAdvU0+sYwuaSSv61zFuYq9EsyOAQ4u3KQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsLsIYOxL6tnTsz3E4z7cH5f129GFaUqTBlODvsByOo=;
 b=fK9z+aWFLrYsZHI67yrkJlRP62eMLFn5i8HvvZeWY7Yd9bHVDVxZQ/0OBggY6qHcJ4LlruuuzzUT3lwY9ZY2eB/6oY8mDAXLWPPykrlguNR9IhO75LRP5U2QFTP3h0kziSqZJmyuUFD3UcQ0h4kHeYPeEsnSiMJfZgivG9TSzd4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB4909.eurprd05.prod.outlook.com (20.177.48.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 17 Mar 2020 12:32:47 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 12:32:47 +0000
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
Subject: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Date:   Tue, 17 Mar 2020 14:32:27 +0200
Message-Id: <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 12:32:46 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 945369c3-f157-4df6-2950-08d7ca6f4c66
X-MS-TrafficTypeDiagnostic: VI1PR05MB4909:|VI1PR05MB4909:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB4909FF89C14A8DFB0BBFB20FF9F60@VI1PR05MB4909.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(376002)(396003)(366004)(39850400004)(136003)(346002)(199004)(54906003)(44832011)(956004)(52116002)(86362001)(36756003)(186003)(6496006)(8676002)(81156014)(4326008)(16526019)(81166006)(8936002)(26005)(2616005)(316002)(5660300002)(6486002)(66946007)(478600001)(2906002)(4744005)(66556008)(66476007)(55236004)(1076003)(6666004)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB4909;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWDPvq3ATQVxjQD1wMZEM9rFE+aoz5eq6gnx0G4rpexiyKJ4JFuXZ6rlj1wVNqki1Xj2XcWDyUARIQdtGiq+rq9rn+it3Y/eWsaB8twXmOTsPXEw2Ue7AUCFYMscSKwSjtgb3rC/8ev6mP/dKXCzxmiFzFEFsJ8nsJlMSpUcMrqgk8MI+zbqy4WIaLOvOY8PJR2vHdMva0o4e8tXx9uXM9MXrXL8pk+ONSjXC/TP3SnJQBPq6QuVB+oNyiD/HR3J8nCaxhWofTAmI4QzMIsp1eQSQ3VVXvq+/sAEou8hH/5xKafMHpC8kU8+7maM0K9ylGmPBHKPqEWwni3ECqRb8reeNoN1+p5ndi5XZjYCGfVKvdKxl1+Fn4tORmQq2ie3cYo/3pedN0+8WxwYjKb5qZgCeQmiNHZO5rBfAch7/RWpjnU3xe9hLnX5lIovoPky75dMiCCNxyjabqVrXzA1a1r29QBKB8kn/B0IBeh+2L3Qzqef4xid+EixdOpIyseHwKWiuW3wSMUQ33+RjlUd8IZon3KGXozV866ctdy57kEokWNPb29U7fm7pTTuzTaMdz/N7Y3qZcES/CeOO2j9Lr2YdpCHmbwMFNqrbg5aRGmTMm5fYW6F0yEYw4HLDsst1vIw6tPG8Fyyh8v5dEcPLcgrhy7XMXfzCEkRj95svhfFz24mZpBySVWW/jYnI1eGIQ2sKAuEfK/HfJNjQjLbwa51wOICeOk74QwDyYHVmry3EfY1nO3lioAEVVW68zVAQtMe31e2tgnIpPsC4u8sUA==
X-MS-Exchange-AntiSpam-MessageData: WCbwTaIC73vlqhzBcqiWJNQWS2DzOk6pYfXBdBFe8l9jonZk6nh0yFJ7hVajtsIRfYN2QvJK/uTprxLBro1iBvG0SeHY9H9eT25V3QIYcNkwdc5Osb0JLqcippaCbP2LKQ+gyqdWdXa4dz4ukDZ0vA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945369c3-f157-4df6-2950-08d7ca6f4c66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:32:46.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd13YrcasVMARE9qpfIsuUKM/NDSw7Vr2TmQlqcJiTGbCZ9tX7x9o8Grv0Sef2wJ2xvaReV67Y2XeXN8/lzTEzEZYxa9Qs9z1lzOPs9D5cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4909
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PWM can have a normal polarity and a reverted one. The reverted polarity
value is defined.
Define the PWM_POLARITY_NORMAL to be used further.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 include/dt-bindings/pwm/pwm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..6b58caa6385e 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -10,6 +10,7 @@
 #ifndef _DT_BINDINGS_PWM_PWM_H
 #define _DT_BINDINGS_PWM_PWM_H
 
+#define PWM_POLARITY_NORMAL			0
 #define PWM_POLARITY_INVERTED			(1 << 0)
 
 #endif
-- 
2.24.1

