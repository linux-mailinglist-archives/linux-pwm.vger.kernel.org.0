Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3564B766595
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjG1HoY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjG1HoX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:44:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AB82D60
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52256241b76so2299060a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690530261; x=1691135061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRl0Bgp8YI4V7+/GQyUNiAMXvM15FZUOcNGe3OAMBTk=;
        b=brJ/gbfNHE0mr1YfjrmlPE7LnP8Ycqp6fVJd6jx195+Zl1RZSYuG0tXMV8rvnmCkuL
         Y/athc+40XcsfWUzYLfluU6/oc/EpiV3JwuLNrn9dtdL2Cb4okcW0xXVaf5AoChHh1AT
         xFJmI2+OsZ6F7O+598mUga/cs2WMeG77MbW+atJJS+/AhTdv7/KxtCdA8eo+HAZdoq/3
         msLiPQv2LPRHbeoLYNMI0mmCMYG5FqT6dJo6ZOOSt9OLXIgLigrTevzJcuxHM9uvAkf1
         gjrTI1d+6a47YfwMjUXMVhJp4W86gmDdBcc3TjI7kg4jhw+zx5M5WG6rLkf2bJVIIZLn
         trNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530261; x=1691135061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRl0Bgp8YI4V7+/GQyUNiAMXvM15FZUOcNGe3OAMBTk=;
        b=I+rvvjiSzxRtC6LlENG0zFA4cROB5hpNnqlUboSDBVRIg2v+fosRZ7jvZ71n7LGTbb
         Tku/qrSFT100yEd+IwQJIxBrEZnPFQu3tALDUAm2mJ3YP8i2runs2+JtmnvghomMT8d/
         LpKYvEI82Mid9Fvn8vaVmTVlyaIifIjhLGuEM5vH9mDIx9Ilc0DsN8H2uHNN+ADeIDQN
         7PoEJI9I99MMqo7zi3MuYDCu6mVE+HkyAT5lfw6xrs42xmQuaYvmvulRNNwfCG8/mIlk
         CdzjnYiiISgrXxUuwSIqyodlJrVk72v0MAmPL3xTlrGjKIRk4ALe1wWPKoITdmn0+rYQ
         UnBg==
X-Gm-Message-State: ABy/qLaAVWeFTzdtHYaVufueojLsoJFvSxX5TjcQe90nxs8blwJ51l9x
        MRPk7fAIeOc4Bzz60LkaHFk=
X-Google-Smtp-Source: APBJJlGPj/Ru/PMizIOTCLn7l1z8OEtp1pAlDuyZG24CKUIYPxYrLhKjJUToUDKGfFP8OvQZiuSzCQ==
X-Received: by 2002:a05:6402:14c7:b0:522:37e3:74da with SMTP id f7-20020a05640214c700b0052237e374damr1273837edx.5.1690530260879;
        Fri, 28 Jul 2023 00:44:20 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7d945000000b005223e54d1edsm1481282eds.20.2023.07.28.00.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:44:20 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: lpc18xx-sct: Simplify using devm_clk_get_enabled()
Date:   Fri, 28 Jul 2023 09:44:14 +0200
Message-ID: <169053024117.3514419.4461077031701276052.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718144128.371818-1-u.kleine-koenig@pengutronix.de>
References: <20230718144128.371818-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Tue, 18 Jul 2023 16:41:28 +0200, Uwe Kleine-König wrote:
> With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
> dropped from the error path and the remove callback.
> 
> 

Applied, thanks!

[1/1] pwm: lpc18xx-sct: Simplify using devm_clk_get_enabled()
      commit: 4aed0ccd6868e6ec71f0cf26fc755dbd67447072

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
