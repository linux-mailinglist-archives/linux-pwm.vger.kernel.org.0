Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61075EF21
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jul 2023 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGXJag (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jul 2023 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGXJaf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jul 2023 05:30:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D07F3
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2023 02:30:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so58316621fa.2
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jul 2023 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690191032; x=1690795832;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR6qSxyiyJpt9A/Z8cWAd/ggm03WbEHNOfBsVLzhOho=;
        b=JMC9eNdgoo6Brfu0hns2+P79kub2hqCd0bkXWjTS0hQqZYq3cwZDzELTW66LR5XcoT
         /vCKkbB8KrPZd/Gohzr9ABGCKrplWeH2UE/7UWC0m9uS30kUeSl8Jf7buxX+NhiU4Dms
         9wX4clq4wSpUonUhszkTKcpi8yIVQVxwvOEBcKzPuVpTOVd9rA1VLnQvorD1iuajIdB5
         GrWmzHDU5cEBwp6j6Zzf8vw2a7kPeQ3mbp4S09c+qEcI/tfHNpDKlvFA6+1M124S1p5x
         EnB4N1CTO6J6//8SZ9Mm0RASdn0YrSCQiESjaG3omYevCyW8He07q6qaI/rOlRS9taYX
         ZUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690191032; x=1690795832;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR6qSxyiyJpt9A/Z8cWAd/ggm03WbEHNOfBsVLzhOho=;
        b=XSlq5MY0PVSzQtZS5qPGHbU+4lUFQVOIIuL+pnUvR/5CljQ2WuWCqDdE/cCf6K+LJ2
         0QLILB4Rd7SaFyRogHDNvdg6Avh/8YaBznqRFjKgsKPJTY/DefxhFHdIR0ZPwY/ie74j
         RTbasob5m5IxYKw8NWlBV7ltzmVhgOsgvWCpeD0xfdkNhFgjjTq8+H13QbdwkfUKFs3Y
         YcvdEa9yJa4IJmmhKZP2JDTuu6DiMnp1jb+epeJhaDGbzro8CGtkP6zHLbOP9pfPEdKN
         x2XlvvNwCC41bDsE8/kwT+q7etOBPdufk1qNjHAA0KBL/mwSYhXECVKWxmAlWoQjZSna
         wniQ==
X-Gm-Message-State: ABy/qLbeB22KqbpMQTbo7bDQ/8gLOtjCfYd4O8E0gNFcbzAG/tZSMYqy
        Ckm+FrdvVuHCJVhYrF1hHPmwcRQOe8neIHpJSwg=
X-Google-Smtp-Source: APBJJlF4Qb1v5tBfKCy/g8MhmuCMS/FA0jTIzvi4q310YTJSB2ew9aGSyAj1fQ15+U9YJ97wONUrNA==
X-Received: by 2002:a2e:9214:0:b0:2b6:e292:85ab with SMTP id k20-20020a2e9214000000b002b6e29285abmr5657993ljg.25.1690191032659;
        Mon, 24 Jul 2023 02:30:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c22cd00b003fbcf032c55sm12320330wmg.7.2023.07.24.02.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:30:32 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:30:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     u.kleine-koenig@pengutronix.de
Cc:     linux-pwm@vger.kernel.org
Subject: [bug report] pwm: lpc32xx: Don't modify HW state in .probe() after
 the PWM chip was registered
Message-ID: <919cac5d-491e-4534-baed-bf813181192d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe Kleine-König,

The patch 3d2813fb17e5: "pwm: lpc32xx: Don't modify HW state in
.probe() after the PWM chip was registered" from Jul 7, 2021
(linux-next), leads to the following Smatch static checker warning:

	drivers/pwm/pwm-lpc32xx.c:144 lpc32xx_pwm_probe()
	warn: pointer dereferenced without being set 'lpc32xx->chip.pwms'

drivers/pwm/pwm-lpc32xx.c
    121 static int lpc32xx_pwm_probe(struct platform_device *pdev)
    122 {
    123         struct lpc32xx_pwm_chip *lpc32xx;
    124         int ret;
    125         u32 val;
    126 
    127         lpc32xx = devm_kzalloc(&pdev->dev, sizeof(*lpc32xx), GFP_KERNEL);
    128         if (!lpc32xx)
    129                 return -ENOMEM;
    130 
    131         lpc32xx->base = devm_platform_ioremap_resource(pdev, 0);
    132         if (IS_ERR(lpc32xx->base))
    133                 return PTR_ERR(lpc32xx->base);
    134 
    135         lpc32xx->clk = devm_clk_get(&pdev->dev, NULL);
    136         if (IS_ERR(lpc32xx->clk))
    137                 return PTR_ERR(lpc32xx->clk);
    138 
    139         lpc32xx->chip.dev = &pdev->dev;
    140         lpc32xx->chip.ops = &lpc32xx_pwm_ops;
    141         lpc32xx->chip.npwm = 1;
    142 
    143         /* If PWM is disabled, configure the output to the default value */
--> 144         val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
                                             ^^^^^^^^^^^^^^^^^^^^^
This is a NULL dereference

    145         val &= ~PWM_PIN_LEVEL;
    146         writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
                                             ^^^^^^^^^^^^^^^^^^^^^
Same.

    147 
    148         ret = devm_pwmchip_add(&pdev->dev, &lpc32xx->chip);
                      ^^^^^^^^^^^^^^^^

lpc32xx->chip.pwms gets set to non-NULL here.

    149         if (ret < 0) {
    150                 dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
    151                 return ret;
    152         }
    153 
    154         return 0;
    155 }

regards,
dan carpenter
