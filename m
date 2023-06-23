Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7463473BA9E
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jun 2023 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFWOvt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jun 2023 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFWOvs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2023 10:51:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE19DE42;
        Fri, 23 Jun 2023 07:51:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-311367a3e12so841301f8f.2;
        Fri, 23 Jun 2023 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531906; x=1690123906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+3LHeauprJMFrQd0+jQkGFlCp8ECRd37XuNslV2KI4=;
        b=MinrleaBYcgn0SmOruI2S1QUSW3aFfm+GZoBJAolHuG58GBKj27ZOIKHri8o9uoLg/
         VdUBW87sjF9wyCnBloDKdw/QhZMECJgrnfbrmW3qe/9LgiZbuC1BUD8WLZ73ydzrVSqZ
         65SRi6chDkKWKA7RU+hbwtdET3d6uL+OHyPNdA48//dLy4uXi7cBh6qQ1zk2u3oKobSY
         4f4LMcHU4o3t1TNyW1xHUKUsnyf/VSXVu+3zb4Spv9uqLpmjuage8Of5qOm4IbOYZopd
         Bk/c48Vsnye3NluNaA5L3SACMQHf4bskHdSvjJxY5vbFF0Mnjnnr5rPEsvXBBX1O9CXQ
         kePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531906; x=1690123906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+3LHeauprJMFrQd0+jQkGFlCp8ECRd37XuNslV2KI4=;
        b=AyJu3J7uvqR/I26SkfqzfFefk9A1reeXHhlzMKVuRmq4g5GBjQjHg232y8vEXLmRUy
         IwFYNxH5BQdsn6LWgcwZQJpLlOKxpJ/UuVcCiFaHI4JRAKXOc9ORw7Q8W+F6sNHJss8U
         RJZaSiFH4Q7P9eVmq0qzSwqZ43miIIdXGRD4EJsRni2tWfMHD6PrscVAOrejjGZWSc//
         QJVQ0upBtx26SttHXg9tyj07okQN1JUMDKuWIJnSX14S0tY2sm9nBhaCaHSZkzxU8B5d
         xvQgn6WB1VhP+3tOS6oJQ3SbOkYYg3XariHNXMjtL5nMfk0Sa8qoa+VSahfLBPwxapig
         kEjA==
X-Gm-Message-State: AC+VfDzymDvP4GrMEBvyQanU99pGb59dkBuOnvu8f0bTyJy8wUaWeuFN
        Cau9ye2gVVYRXcSVzCW33aM=
X-Google-Smtp-Source: ACHHUZ60FNRlfUmIFP0b/3cM1TztC5mpMI+ckxGr2qi0N2TeLVaraRnzeYWpPjtELUaJeTm17tpo5Q==
X-Received: by 2002:a5d:570b:0:b0:309:4da8:7713 with SMTP id a11-20020a5d570b000000b003094da87713mr17290741wrv.64.1687531905993;
        Fri, 23 Jun 2023 07:51:45 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309382eb047sm9654388wrd.112.2023.06.23.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:45 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: pwm: imx: add i.MX8QXP compatible
Date:   Fri, 23 Jun 2023 16:51:29 +0200
Message-ID: <168753171957.1191890.13776090502738387691.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
References: <20230424082108.26512-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Mon, 24 Apr 2023 10:21:07 +0200, Alexander Stein wrote:
> i.MX8QXP compatible is missing in the list, add it.
> 
> 

Applied, thanks!

[1/2] dt-bindings: pwm: imx: add i.MX8QXP compatible
      commit: c799ad062a75858e10a7626e20233e6e94dbf554

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
