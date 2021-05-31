Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D542F3954C2
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 06:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhEaEr7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 00:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEaEr7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 00:47:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F6C061574
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b11so5160640edy.4
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz+n+z6h/C9i8J/WRfdsHfGpM50TGPrsItNGlwXy1L0=;
        b=LmP92wi5WKi+0qVT40ulpznUIqIDGJ4m9797edYzDaLvKu+6u4GcG4OMf1ICTG1geL
         Vxjf9R2J8uzxgN4NsXTsDJpc4LnytncaQgYVcibxU9N0V2y1DDZFVrrq/hFs/LaZBVCN
         bZWc3cI1VbuZZbpxE40WlgTz1+jSO9IvWSoA4aMRY+sH3N37x327l/NJa2f6WMFh2518
         5owiw+PchTO5T0rxfWI1LptyTzWWOGkIACTjg4kqHQyMWmorxyIwc4udFfPNsQOT+Cyp
         ZE0tYVQXBnHuKHrG7gDRkt93MUW7c8U/GeWwAys3thG5FEoeJ5TdgrWUXQDX8hZ5bUIH
         EHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sz+n+z6h/C9i8J/WRfdsHfGpM50TGPrsItNGlwXy1L0=;
        b=n+Tet3cQ9WoGV21TeD0Oh3Ix602BaJpjazmcJTrbZOcke1yUl8PZ0AS4q1BmoPoDyR
         srtU5+fELlZ6jpqMG5WPYQKd5uB/hB+CYpY4pSJj+qzflff3Y46ed5SNbw6TFfIYW6jE
         axuOQYZ6s6IIve0dIoFLRYE7KjkImL9P52zokd9bPP7ujwjyFdCx8wVT3XlByPW+F9XH
         zyWd5PcjusdheGnE5VyO6aR+LLCxLG3Zlr84pQTK1j9sgZXLSrbF/1Ki53fH1PX5iEzR
         emXlWf7AQG644i/Gvig6Fg6Vy60G/moQZN+IseqbDUQWGOdQspP20TmUraWTT77Dz4ab
         baFA==
X-Gm-Message-State: AOAM532hGjlVXErkV2Nsk0pE15KNydTLf3usiyTi9rfr5pMwa3WKqSUX
        0gO/yUhCeRKQaznnXcJLBq73KA==
X-Google-Smtp-Source: ABdhPJzgvk3vLxLu+lNopZjiX2qNGlPgmTIubkdp4O/wIzkbFIDKHP+EWojv/tcrirKPk9eUHUELTg==
X-Received: by 2002:aa7:c349:: with SMTP id j9mr15402010edr.48.1622436377511;
        Sun, 30 May 2021 21:46:17 -0700 (PDT)
Received: from zen.local (ip-89-103-215-157.net.upcbroadband.cz. [89.103.215.157])
        by smtp.gmail.com with ESMTPSA id h9sm6238376edt.18.2021.05.30.21.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:46:16 -0700 (PDT)
From:   Roman Beranek <roman.beranek@prusa3d.cz>
X-Google-Original-From: Roman Beranek <roman.beranek@prusa3d.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/6] pwm: sun4i: only wait 2 cycles prior to disabling
Date:   Mon, 31 May 2021 06:46:02 +0200
Message-Id: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As Emil Lenngren has previously shown [1], actually only 1-2 cycles of
the prescaler-divided clock are necessary to pass before the PWM turns
off, not a full period.

To avoid having the PWM re-enabled from another thread while asleep,
ctrl_lock spinlock was converted to a mutex so that it can be released
only after the clock gate has finally been turned on.

[1] https://linux-sunxi.org/PWM_Controller_Register_Guide

Roman Beranek (6):
  pwm: sun4i: enable clk prior to getting its rate
  pwm: sun4i: disable EN bit prior to the delay
  pwm: sun4i: replace spinlock with a mutex
  pwm: sun4i: simplify calculation of the delay time
  pwm: sun4i: shorten the delay to 2 cycles
  pwm: sun4i: don't delay if the PWM is already off

 drivers/pwm/pwm-sun4i.c | 56 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

-- 
2.31.1

