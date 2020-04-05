Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD619ED82
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Apr 2020 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgDETXH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Apr 2020 15:23:07 -0400
Received: from mail-bgr052101131039.outbound.protection.outlook.com ([52.101.131.39]:36883
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbgDETXG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 5 Apr 2020 15:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePPugniI6iSQ5eknyJWMcceSsOhNIXjqjZ2qauFYfCF4LYwWs2njaMbXv/P1UFW4dV0qSZJZhLLEr7I8ZrRqOmh16OJVafTh0N8JaCdE3VAMAfo8kXMzbl+8eaO8V17OGnmQNrcoPyDd6hY8iJzRSqF7pMuQbhFGgNau8nbh2ObRLsKvNeMeY3aYWzxhDAslM7oDV3LfVcXi7RpNsrjdD7I0k383Q9ZCMX9zd1agXmuJtftDG4cTmSwX31F6qOeU1iQzduEScKVCatF5qMBvsjL0mtBG58B1G3jSHZmjXr0gH5spFKqMhVe6W3rpIx2b6sPbCwavdEJjc02DuaZGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kcJJ3LrhzOAf6WydLTWY+fvypIm2z9vdt5jwcnHSGo=;
 b=EThagEwMN+JQEx021d1FW8MtYaBzmYZmjnS3fRDZYyucIFLqij8DMQFV/r8Zy3+aDsYbS8KhhsfVzNu8m9R/RtZ4PLBjC18EqpbUYo5CYcxrwEIuv3Bw0XoK0iazDqemfU3cQS/5UDLlwjPJJLOYHQxk7qgdqk2cLDzN4sJ/DfPiR6HfyFfS5R3boF+Czafxg441y4bJjJciUeTKWog5AYcwsSTZYtRl0al6qILrClsbfWqfTzL+JL6wI0J/OKlVqlPg6+CP2v7f6lFZ7+wJR7TvUkfGUT2Gdo0j4XsLPjKRuLJvlAGIE/GRufpjkUW6Jjhr/iqAwCwtxK4HOgG0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kcJJ3LrhzOAf6WydLTWY+fvypIm2z9vdt5jwcnHSGo=;
 b=FEFriA82G2Bx15SHIh2ABJwoh6mqXFGjYedw+9ir9LHK5S17YXiNpOxvGYwJjlwmEOW21uoNWA6eXEs+VPuX/RKRC5dH/f8fd0ku5qnaym7YRtF9XzEjfbT+q3BcWBZ1Bwz+eiHyN1DUPrJSJxVpEaFiivh0cWhyPgX7wgFvsOE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
 by VI1PR05MB5373.eurprd05.prod.outlook.com (2603:10a6:803:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Sun, 5 Apr
 2020 19:22:56 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 19:22:56 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org
Cc:     Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [RFC PATCH v2 2/6] dt-bindings: pwm: document the PWM no-flag
Date:   Sun,  5 Apr 2020 22:22:42 +0300
Message-Id: <20200405192246.3741784-3-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
References: <20200405192246.3741784-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Sun, 5 Apr 2020 19:22:56 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04882f56-66dc-4670-69a2-08d7d996bece
X-MS-TrafficTypeDiagnostic: VI1PR05MB5373:|VI1PR05MB5373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB5373F39FB640F5476FDBFB54F9C50@VI1PR05MB5373.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR05MB3279.eurprd05.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(54906003)(6486002)(55236004)(81156014)(2906002)(8676002)(508600001)(86362001)(52116002)(6496006)(26005)(81166006)(316002)(8936002)(36756003)(6666004)(956004)(66946007)(2616005)(1076003)(186003)(16526019)(66556008)(66476007)(44832011)(6916009)(5660300002)(4326008)(23200700001);DIR:OUT;SFP:1501;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjmRNTCxfZHsoMgLHZryxfoXhEPE40rxbkaDC0pippK6le5D84Ii178Zdg+jDlzKz5/o/575DZDPC5gzeMuXgVk8Jv90aPkKFP0O8gfgf+ovHPIszq0qa+ftrla42zZRKpqrz669o61lU8YkoINJQ9pitsLgirpWNi2laJ6WEwmn6dUlut4+5YavDZRtNSPY5t/fW1aZ1sNupak3zHWVDWe8TbPqo2d7JiSJeKA396NmlYhGJ6nBotxysWa15goeYaG0VJ+oUQg8P3gOiOPigyszBQtAXmY8qTVkrBrzTcEyut75E02twO/Z1cK2Lln82PBlgOkmxPKqO6qmH6xZIc0xqb6M0BsqayLOv2FNMB7Us/cITb3QEyWFZJsO2qf5jaT4ZPXaCnXRU1gjGVjNabxM0d5h4cHX2Pjtlyr4xPBuQWrNFJS70V+0YRQbPmdadY0IH3ceE2JHE2HcsXUBg3ExVUfdy4QMOGAleSxAoyCHpOgZVg3LjejBkHCCXzonEuU7Uns7aH0c9fV3T83zTTVI1CSl/DnLBsWtHuitmhx1oKmgNsnMlU6nr+XCvhbGXdJ7tv7JJxjWWi5X8Ut9idNdm+e2F+r0pMaHiCFNWHmoINTaribQYs9F4IbW0B/Wsfxjomf8+lFl3X8avdTzQEfpus4YJEWv35YHTOegH8+1DpJ4g6x5ytG8OS9B83Wj/9mR1VJGjmXJRHtshOEPb0FWGtg/tTEVWbO9KnI4gHgfbcHRgTCrA+/ZYbgKwnFaZ6f3Vva5mP8SpVfVvD+CIw==
X-MS-Exchange-AntiSpam-MessageData: gocb/qEI6JBaf6vKcZALOv0RX5sKBOvV405a18yEEZDl2nlBSB4ZTYAFDD6QSYdljsgBJed0AGciAUFxgxfMPLYh/hE8WDp5/IKjDrDI8sYq4Zjwevt3ee9Djx3jh+Rn9Ppz1CTGbethwAvCoTFkgg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04882f56-66dc-4670-69a2-08d7d996bece
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 19:22:56.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JR6Exot1h08geR9/VATG7FDVbior0UkAxAinGbaXIFQq67WAzhm1AmtW9dYfd3bKkqocyqDgQFzupz/n5x03kDK1MC5G8gGs7ULX8Vd5S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5373
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the description of PWM_NOFLAGS flag property.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2:
- add the example of PWM_NOFLAGS usage;
- Use PWM_NOFLAGS instead of PWM_POLARITY_NORMAL to avoid possible
  conflict with enum pwm_polarity in <linux/pwm.h>. Also, this name
  reflects the sense of the original value more precisely.

 Documentation/devicetree/bindings/pwm/pwm.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 084886bd721e..7f0bbda127c4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -45,7 +45,8 @@ period in nanoseconds.
 
 Optionally, the pwm-specifier can encode a number of flags (defined in
 <dt-bindings/pwm/pwm.h>) in a third cell:
-- PWM_POLARITY_INVERTED: invert the PWM signal polarity
+- PWM_NOFLAGS: no modification flags.
+- PWM_POLARITY_INVERTED: invert the PWM signal polarity.
 
 Example with optional PWM specifier for inverse polarity
 
@@ -54,6 +55,14 @@ Example with optional PWM specifier for inverse polarity
 		pwm-names = "backlight";
 	};
 
+	vibrator {
+		[...]
+		pwms = <&pwm1 0 10000000 PWM_POLARITY_INVERTED>,
+			   <&pwm2 0 10000000 PWM_NOFLAGS>;
+		pwm-names = "enable", "direction";
+		[...]
+	};
+
 2) PWM controller nodes
 -----------------------
 
-- 
2.24.1

