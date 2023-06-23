Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE373BABE
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jun 2023 16:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjFWOw1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jun 2023 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjFWOwL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2023 10:52:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E721BCA
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:52:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f9c88ac077so9299355e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2023 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531923; x=1690123923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrkJUzJUp2WADx5eXb4XtyacPi/QiRbXzssaYef9j8o=;
        b=ny36mhnfQoSAw+ahrfVCPdkxAMOFybIKD5vjnF+smgllTvh/QxJmntvSMCzur//WzG
         AVn8T/mzvCBv9lYD6hhe3chvCWvjf5MmxWEOlDHpKsm457ShyJJhI/Lr4SjQcoQYoDO6
         RtBcWqia9Oox/sREPc8VsJ5HyydGMgLhbywPbl8gwqk5TgS847Q7hYJXXVVHH2+uJygF
         SdzYEQp9EY7CbkYNfIqjzU4KUwCKiW/rVGP9/9LZmxBjbhvbALfhKcJHOpG3n4xIgKZA
         vgFosoUq+2d3JVkv/rflnaxswpImpToWculLQeIYsVyrneh/pZQnq4JNG5SK763hIBdG
         HzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531923; x=1690123923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrkJUzJUp2WADx5eXb4XtyacPi/QiRbXzssaYef9j8o=;
        b=aA7xsN5nA1LPlBR9ORMd/YQZ8kyVH2b35xPnAQdZ6e7au0Y4La/nvIMVPQvOOkIHtI
         okBb49tPTVB7KIIaomRQoKNVp7bz9UzUvvaDsDDL0g76OISLFhl+W/AzUICLRN3mVGn9
         rFriSu7bt2qsupikftFQUrbd8yZdPevwBD9VdkCje8SHRw4zv7qiGM8aJg9MsUhRr57Z
         6uHmHIqAK03lU/Zv6nkmHkOkZ72S2gFlQuKZyHyEumjPkagM12VKw1sT4+Ayjf5NU+7p
         o7Q2aofRGjZ90kftwYbej8dd/KMbBIiIsYF998DGQYIxocQpT8LjDG4nizHIaXf6CqW5
         D0lA==
X-Gm-Message-State: AC+VfDyUi1TN2wk7fBUF6NH8NRoSgrAldniB1TP5Jwzrq/AA5b4ydA1L
        ky8IWgSvwgq5smBHLVFnaZc=
X-Google-Smtp-Source: ACHHUZ7PbbDFy0qCLXMaugLgslyIHKhRMW8QtHUxpZII9sycjohqWBo20YTWzSUgPuYsavKKPDTW+w==
X-Received: by 2002:a05:600c:2142:b0:3fa:7c2d:b4bd with SMTP id v2-20020a05600c214200b003fa7c2db4bdmr1651568wml.8.1687531922797;
        Fri, 23 Jun 2023 07:52:02 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f6-20020a7bc8c6000000b003f7ed463954sm2552584wml.25.2023.06.23.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:52:02 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: pca9685: Switch i2c driver back to use .probe()
Date:   Fri, 23 Jun 2023 16:51:40 +0200
Message-ID: <168753171969.1191890.15433588084730525920.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230525211305.736102-1-u.kleine-koenig@pengutronix.de>
References: <20230525211305.736102-1-u.kleine-koenig@pengutronix.de>
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


On Thu, 25 May 2023 23:13:05 +0200, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> 
> [...]

Applied, thanks!

[1/1] pwm: pca9685: Switch i2c driver back to use .probe()
      commit: 8bfc651a28ceaab5334d7284a31fce7cb1615348

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
