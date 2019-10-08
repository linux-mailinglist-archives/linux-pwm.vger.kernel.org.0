Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B30ECF92B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2019 14:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfJHMFS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 08:05:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36426 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbfJHMFR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 08:05:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so11749110lff.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2019 05:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIqqIP3EIw1WUky7Dl5KboQRqFaypkEePxm8k0rEc9o=;
        b=AponybTxAeH4Qwys7uf32YeqpoJ78jgDddTlKOmqmCAlexPcNn8x24ajVQ+O7+xRkR
         RuBT096o6RaBaaTnFRhKPGbBnK69SeSdi0jX5VxETzV8yWF+FlbeSjLE8LtoSz+LXe/9
         1SJ01i6mDKGlRWpaglFSkyprM69Ur66rByxaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIqqIP3EIw1WUky7Dl5KboQRqFaypkEePxm8k0rEc9o=;
        b=Xm1wSznlh/SHy3lenr0cXVVicblipBucTSHuM45m1lZfhVoHjhELgLmAeetyYeyN4H
         BW4a9fazGvQ77OPJ2wpnHR2k9/ivHtp5ufIlGTvd4kFEHGSx8BJZoB73tXmZfOdEl/30
         Wf4uuDikylmGYRmMG7n1tjO7iB7PYVMiZx0St/WoPq6167gIg+ILpaok951ulekagU1b
         dZBDDMBzV2vM1sj+HEVf7XcOmbskg59rs+za+CPXdOuh4/hPMXUKH5+j8WrUpQSD/5kb
         ldaTOEs8CrxM/sSzSjxgVazY3nBfZein+ggBRc774+jk+U7v86BBUI3ppoFo46zAMtnE
         TOZg==
X-Gm-Message-State: APjAAAWmGlKI1IFkWGd/vBrazFppZv+6FdgGk33rtzXHbrrkg0/FoSdn
        MQ3qmlqVXG+ek8DgRXefs9BVtw==
X-Google-Smtp-Source: APXvYqykeLmJ/WUhlQxva8zZaqPikrZhQ2ld9WnisNftyHunM8rSa4gXa55Lqcwffs1sdJgebXd04g==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr20438594lfa.189.1570536316077;
        Tue, 08 Oct 2019 05:05:16 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z18sm3918033ljh.17.2019.10.08.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:05:15 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 0/4] backlight: pwm_bl: optimizations and small fix for cie1913
Date:   Tue,  8 Oct 2019 14:03:23 +0200
Message-Id: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

These patches optimize the cie1913() implementation by using fewer 64
bit divisions and multiplications. It also contains a minor fix for
the linear constant used.

v2:
- Drop patch 5.
- Fix thinko in patch 4, otherwise no code change.
- Better changelog in patch 3.
- Add Daniel's Reviewed-By to the four patches.

Daniel, I took the liberty of adding your R-B to patch 4 despite
changing it a little to fix a thinko - I should add 1<<31 and not
1<<15. Please tell me if that was inappropriate.

Rasmus Villemoes (4):
  backlight: pwm_bl: fix cie1913 comments and constant
  backlight: pwm_bl: eliminate a 64/32 division
  backlight: pwm_bl: drop use of int_pow()
  backlight: pwm_bl: switch to power-of-2 base for fixed-point math

 drivers/video/backlight/pwm_bl.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.20.1

