Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E012E6E0A25
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDMJZe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDMJZd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 05:25:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE41A4
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:25:32 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id q5so8054565wmo.4
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681377931; x=1683969931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmM2Iumz0wCty9ffU6sJazDTRuVNx11Hj/8rUPFg/VM=;
        b=rvDLnCyCtCM69vYo9/NJ+axluCUjrwXbd0x6w6yn8+QSHhoQdODZ8V55IcC3u7KqM7
         bxoHBwhI+/DHEjf6SLKDvCCKZSiTdc2VJHo5zBl4krXuoMLRVFtG2y/4MyYXVhKu/i74
         oL+6JnQyDrqG2TUHoFPsHPsUcYbFEdFnSfU5yNguULo1zCqfvp1Fa3nN+SsE6/MxvtDu
         0FuV48NWdUnyYaXjYRL88MNiEhAdPzFMIgOFK0tNY+9O0Ou6vMhKYGmhglAzMSmFeRFK
         6aZICtK9gQ8j8ibaBaPu5B011aKR1mFhFVjrWO5q3KV6raX1ux4oi1yDxRyqm8wsECla
         0pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681377931; x=1683969931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmM2Iumz0wCty9ffU6sJazDTRuVNx11Hj/8rUPFg/VM=;
        b=jQC9D7gqnRBnWSL8teq2gDdDD08Rc5avxB/pybY5/7eOo/bl36GU/DZ6hTqVQxSh/6
         o1+HAS0MS5LdKGRzT+QAF4Tv2Y95esqFPf9NiHXUpf+0y73Pkl81qHarp60bHCeZm6H9
         tiGYlwz5QIYRjpDnagW9FXbyH+qTLqA2U5P3uiBHTo+0L5m7DAFEn/4fMtEA799tyruN
         zdY3TCxUrJPKaK3sIRYRsPsjgqWnIt8L+t3HsG9MNHSA3qERSfohxGbbG7tWp2qvil//
         VghXjHELTX6bgIGBKBwx/BXtYYqJGs6AEWOlUkxmchnSSkzdhQvGGUmbIjgt5ND7P3sj
         tlxw==
X-Gm-Message-State: AAQBX9fY1Tk7RLiKrC8z6GhB8QcUsIzMBLZ7fCzC4MZbMxwRYtLeXDGt
        PcBOhFm611qMJvBwvpfelh8=
X-Google-Smtp-Source: AKy350bSedNi5QuhggJdNoxRcLrb4wiyesVKP7d3sWXVkEafZm+s5Ri0+xIF7kqYbPQb81iiI3rxEw==
X-Received: by 2002:a05:600c:d9:b0:3ee:6d88:774a with SMTP id u25-20020a05600c00d900b003ee6d88774amr841701wmm.14.1681377931180;
        Thu, 13 Apr 2023 02:25:31 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bcb07000000b003ee70225ed2sm1316522wmj.15.2023.04.13.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:25:30 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH] pwm: meson: fix g12a ao clk81 name
Date:   Thu, 13 Apr 2023 11:25:30 +0200
Message-Id: <168137792161.301968.13202173892797133220.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <b53af028-28df-105a-eb50-21a1ed4e15b5@gmail.com>
References: <b53af028-28df-105a-eb50-21a1ed4e15b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 11 Apr 2023 07:34:11 +0200, Heiner Kallweit wrote:
> Fix the name of the aoclk81 clock. Apparently name aoclk81 as used by
> the vendor driver was changed when mainlining the g12a clock driver.
> 
> 

Applied, thanks!

[1/1] pwm: meson: fix g12a ao clk81 name
      commit: d02037e2297dcb0e705bfbd6c11278b48e330f97

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
