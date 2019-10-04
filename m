Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0FCB409
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 06:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbfJDEx0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 00:53:26 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:6114 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387976AbfJDEx0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Oct 2019 00:53:26 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 00:53:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570164805; x=1601700805;
  h=from:to:cc:subject:date:message-id;
  bh=jWL5W27uUFoqE45P9aToaJkEZWCPur2rRlOPC00wtwM=;
  b=IEMA8Apzm/u+hUBVdFgwDGJJVBRoyPeqBf90XRcxtfqh7YYXKEOoP8zc
   rq8HOWvOM9dJDxLl5QXnlkDfk5WGFTqcUXZftEvS77QnAYrah1vHA4Twm
   F881F0FJJax6LGrYKkfoeMKk35EpSX2EdJlXH4OP+AQESJZBokj7z/zJG
   +38yYD/vvPuAIkEEnFIdKyWpPGD3PdipePjy3R/wOPspyV5Zs8LViFHqb
   H5AOMnAqZRlNdO0+7TAhGCYPL8BZg209PEBDBVguipCZT/8wn2i/WfBsb
   HsEcrPfaDz3RiPZV+ss0AwFO5sKP+R2wQ8Cantf/N+8NrhIhZhcEvEuZX
   g==;
IronPort-SDR: ycPJTiP98ztSVqAHn+0UnWiknFgCEuUl3EQi1CsWD6JLAaHMmLXOAWh8HOViqLe7/C8rJ2ds+v
 dETvUjBZlhXLLUtOFf4M4f5WXIpMxPypPgsKrtjmNvI1F+n1OWmhBjbQBy6nkQHKCLNpbJdmIu
 F/QlH5D6b8iL90BqpMGbFatG3O+zm9G1mfVCTnmn7tNOKtwXAppQSIaOoEpidC2wgPz4tjc6eV
 /3PUcOvQp3JNhGLmCOC+R2LWTiR+xp64tRutnCjexDb9qrR5Whl8eZwUPOcy8CKB52tY5x4Aib
 WDk=
IronPort-PHdr: =?us-ascii?q?9a23=3A55Y0HRSIK/dFGn4hvpIks6lU5tpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yZReN2/xhgRfzUJnB7Loc0qyK6vumBDRLu8zJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Ru8UKjoduNLg9wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSlBAoKnb4sUDuoBO+lYpJTjqVUXsBC+CwisC/3ryjBVm3T62aM33/?=
 =?us-ascii?q?gkHQzA2wMtA9wDvGjJoNnsKKseTP2+wK3VwTjDav9b3yr25orVfRA7ufyCXa?=
 =?us-ascii?q?x+f9ffx0csEA3IlUmcpZD/Mj+JzOkBr3SX4ux9XuyvkW4nrARxryCtyccti4?=
 =?us-ascii?q?jJhp8VylfZ/ih+wIc0JN24R1R6YdK4DJdduTqXN5ZqTcM4WW1npjs1yqAftJ?=
 =?us-ascii?q?O9YSMEy4wnygbBZ/Cbd4WE+BHuWeaLLTtmmX5oeKiziwiu/US80uHwS8i53V?=
 =?us-ascii?q?JQoiZbnNTBtmoB2wLS58SdSPZw8UGs0iuV2Q/J8OFLO0U0mLLeK54m37E/iI?=
 =?us-ascii?q?IesV/GHi/qgEX2i7KWdlk89uio9evnZrLmq4eZN4BuiwH+Nr0imtSwAeglKw?=
 =?us-ascii?q?QOUXaX9fig2LH58k35R7JKjvIykqbHqpzVOcMbpquhDw9U1IYs9Qq/Ai+43N?=
 =?us-ascii?q?gEmXQLNlFIdRKdg4T3Jl3DIOr0Aemjj1iwiDtrwurJPrzlApXDNHjDl7LhcK?=
 =?us-ascii?q?596k9dyAo819Ff645IBrwPO//zR1P+tMbCAhAnLgO03v7rCM9h2YMGRWKPHq?=
 =?us-ascii?q?iZPbvWsV+J4OIvPuaNaJYNuDfzLvgo/ODujXAnll8HZ6Wp3oUYaGq+Hvt4J0?=
 =?us-ascii?q?WVe33sgs0OETRCkBA5SbnbiU+CTDkbM2egX6s9vmlgIJ+tF8HOSp370+/J5z?=
 =?us-ascii?q?uyApADPjMOMVuLC3q9MtjZVg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FFIgBGzpZdgMjXVdFlHgEGEoFpg1x?=
 =?us-ascii?q?MEI0khV1QAQEBBosmGHGFeoMLhyMBCAEBAQwBAS0CAQGEQIJIIzgTAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQkNCQgnhUJCAQwBgWopgzULFhVSgRUBBQE1IjmCRwG?=
 =?us-ascii?q?BdhQFoVeBAzyMJTOIZQEJDYFICQEIgSIBhzSEWYEQgQeDbgdsh2WCRASBNwE?=
 =?us-ascii?q?BAY12hzWWUgEGAoIRFIF4kxQnhDyJP4tEAS2nLwIKBwYPI4FGgXtNJYFsCoF?=
 =?us-ascii?q?EUBAUgVsXFY4uITOBCIJpjVoB?=
X-IPAS-Result: =?us-ascii?q?A2FFIgBGzpZdgMjXVdFlHgEGEoFpg1xMEI0khV1QAQEBB?=
 =?us-ascii?q?osmGHGFeoMLhyMBCAEBAQwBAS0CAQGEQIJIIzgTAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQkNCQgnhUJCAQwBgWopgzULFhVSgRUBBQE1IjmCRwGBdhQFoVeBAzyMJ?=
 =?us-ascii?q?TOIZQEJDYFICQEIgSIBhzSEWYEQgQeDbgdsh2WCRASBNwEBAY12hzWWUgEGA?=
 =?us-ascii?q?oIRFIF4kxQnhDyJP4tEAS2nLwIKBwYPI4FGgXtNJYFsCoFEUBAUgVsXFY4uI?=
 =?us-ascii?q?TOBCIJpjVoB?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="80567868"
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 21:46:03 -0700
Received: by mail-pg1-f200.google.com with SMTP id 6so3510161pgi.10
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2019 21:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=psYXa8mIT1FkAshfcFCubEkA00yN3VjYG8rNmfjs5/o=;
        b=qlhGHeUfOAuykvEeWjmhK/UKmrw2yGjT9mNTmwLDapL/L/a8Kx9k94gL5OEZ/JeSb4
         rgjaa8VpzTnLkzE6uCd2NdRlh30BGCnKviE3E2jmr2q4RiRfLX2NyzTsXp2gqy6AbeTd
         +En7OTEVlDWM+1MSQpnQahRvknrslgGALiZw8US2t6HTRlBvTRCLGNMr884sfEJW0KIi
         t8gwINeZJ94UZ/OFYFyvC6PF+WwXFc256H85jcms6zO30ps9snxf010tL7VirQNR6zTF
         +1dU8XjN7yme8HgOh1wioVf76FNWgFkuRm+gX6JVZBBHwe4aMi8ekDyBlDTsJMJP1kdu
         7gkw==
X-Gm-Message-State: APjAAAUaHEzoA5i7HkJUnJg7XMTHxwVqNHSnNli+3Bcf2EkDeCGCZiya
        DOGwH+8RNNbER5WMU8rSOf1aHDfF3EgEKHz+nCBznjINu2toClY5Dn1PrAbF1lTlWtKhdhNRPPe
        BGWpaxGwlo8GpNVqA7duddQ==
X-Received: by 2002:a17:90a:22b0:: with SMTP id s45mr14621632pjc.22.1570164362693;
        Thu, 03 Oct 2019 21:46:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGjRTgwnhlo2KZICWhErm2QBBJwJvYEziM2d39vj6xXurXwJPnB9wMG3PeWPQZzN2CBEQCIQ==
X-Received: by 2002:a17:90a:22b0:: with SMTP id s45mr14621596pjc.22.1570164362245;
        Thu, 03 Oct 2019 21:46:02 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id p88sm3786036pjp.22.2019.10.03.21.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 21:46:01 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: stm32: Fix the usage of uninitialized variable in stm32_pwm_config()
Date:   Thu,  3 Oct 2019 21:46:49 -0700
Message-Id: <20191004044649.2405-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Inside function stm32_pwm_config(), variable "psc" and " arr"
could be uninitialized if regmap_read() returns -EINVALs.
However, they are used later in the if statement to decide
the return value which is potentially unsafe.

The same case happens in function stm32_pwm_detect_channels()
with variable "ccer", but we cannot just return -EINVAL because
the error code is not acceptable by the caller. Aslo, the variable
"ccer" in functionstm32_pwm_detect_complementary() could also be
uninitialized, since stm32_pwm_detect_complementary() returns void,
the patch is not easy.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/pwm/pwm-stm32.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 359b08596d9e..22c54df52977 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -346,9 +346,15 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	 */
 	if (active_channels(priv) & ~(1 << ch * 4)) {
 		u32 psc, arr;
+		int ret;
 
-		regmap_read(priv->regmap, TIM_PSC, &psc);
-		regmap_read(priv->regmap, TIM_ARR, &arr);
+		ret = regmap_read(priv->regmap, TIM_PSC, &psc);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(priv->regmap, TIM_ARR, &arr);
+		if (ret)
+			return ret;
 
 		if ((psc != prescaler) || (arr != prd - 1))
 			return -EBUSY;
-- 
2.17.1

