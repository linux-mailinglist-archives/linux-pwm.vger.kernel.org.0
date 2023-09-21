Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED64C7A9B26
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Sep 2023 20:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjIUSys (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Sep 2023 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjIUSyT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Sep 2023 14:54:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7968EED560;
        Thu, 21 Sep 2023 11:44:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-69028d0fab1so209202b3a.1;
        Thu, 21 Sep 2023 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321875; x=1695926675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL0bZo/5seRmQ1p67g8wgY/90dvrygUhJttKGE9q9es=;
        b=RT2RRmo8xJ/JBvwf9SH+9t/CvNChs0QkE73SZvX6Sl6sjHeS7uDz5Xiip6pmhcngg7
         LyExWDxR1rggY0OMrgiBNd0FOfieqisa2lZjZIwnyGSzmKpRJ5OC/pBc+oTWlk8v9+3x
         pp565jM4Ab9mSYLJribX9MJdJsmT+anheMMb/9QxkQtKB2mhjX4ABy8IOwladJjIJ3YC
         We9nwpn5bwdSoopqVulqIdcbGPjZAjsmQm4FoZ/I07HySP+QNNuLmaRK7GEakXAnDT86
         BsbcOTiufvhhAsMDuvaphKBhllq4Kll3HsUmu0+zCA9MNbP7HaIuqNCZPky8vng5dnPL
         alww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321875; x=1695926675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL0bZo/5seRmQ1p67g8wgY/90dvrygUhJttKGE9q9es=;
        b=J5+eh6Z3JviR9ehr9RRVPkzJJhSCSoeJJc265jjusDrF9FFMstjhFYRyAm480Y4p4q
         K1Pm2SvtfePpHfYp6z+N7Q8vOwQYrTQER4tbYcMyBlN+BAhk+LpnHl68xJnxUJdHHFBd
         8KVEFMC+nE4swASk7PFBuatugzrguDgnATZ0jqt/y8j1aTE4RVDwP91wTWpKNo4ecZt7
         tMFZ5nb6gWi9lixuMqjeVZbxQS+/wqVfapJCidCvfJpBzH/3KR+vSLXWSaZfIGc5CGn1
         SvYVO14y48kzQUQYOd2ES0R2UXC+4dgo9n6qRNmR+nTjTm8q/dMs0LAMv8Ffgt998QUt
         dp9Q==
X-Gm-Message-State: AOJu0YwoO4ENW6fnu5yEeFswGohqY68A96VefX3kPFr/B1J7uqGSbFm6
        efHEIuhClbp1Ay6TxYKIkiA=
X-Google-Smtp-Source: AGHT+IE/ImEQxdOeZQigsPJKWA1EdHeirBYxWHR6Wo2bgxZH5ceA76iyUZ1ku/3UYn9l6A1mDH+/KQ==
X-Received: by 2002:a05:6a20:440d:b0:15a:3285:e834 with SMTP id ce13-20020a056a20440d00b0015a3285e834mr6050546pzb.4.1695321874853;
        Thu, 21 Sep 2023 11:44:34 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3568:5db2:51a5:e134])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001b8b07bc600sm1852730plh.186.2023.09.21.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:44:34 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] dt-bindings: pwm: mxs: Allow passing #pwm-cells = <2>
Date:   Thu, 21 Sep 2023 15:43:48 -0300
Message-Id: <20230921184348.290261-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921184348.290261-1-festevam@gmail.com>
References: <20230921184348.290261-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

All the in-tree imx23 and imx28 devicetrees use #pwm-cells = <2>.

Allow it in the schema to avoid warnings.

It is still possible for a devicetree to pass the third cell with the
PWM polarity though.

This is similar to imx-pwm.yaml that allows #pwm-cells to be 2 or 3.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
index 8f50e23ca8c9..405c6412dd5f 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
@@ -29,7 +29,9 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 3
+    enum:
+      - 2
+      - 3
 
   fsl,pwm-number:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.34.1

