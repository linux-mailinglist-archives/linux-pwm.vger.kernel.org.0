Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4186D9A81
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfJPT4H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 15:56:07 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:41613 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbfJPT4H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 15:56:07 -0400
Received: by mail-il1-f179.google.com with SMTP id z10so3884240ilo.8;
        Wed, 16 Oct 2019 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h/P3JA46kWkR1ok83p5Cbw7TV2607e8IBxUrOI+c/JY=;
        b=Sum1X28FKUFNIoD0TNCMnYgp67D/UN5XOavrIbFzvM2OhQqxcIp0ZcOU/WPmuTG97l
         WrFb0fodakzC54W5Ff73sJr/YUykiA4jcILXc/kv0/7pBCt6XjQQvcQShAf2pTNkF6o+
         b21vOXJhCIT/oiuwPd8iHKE9yOGo6CLKbT7sHkiElIe0Ryqnh8hmtoj9j8xxRU9s/HGz
         VNKIigtDHhmedxxSla4gD2d/jwbsRQ7Vw1mIAq+CgTUZHQ9iG/79+BjXsZWv/g+GnZI2
         R0JgYpjCuJqBF0TpAMWyBzyc69+1ffJpaxnK5gNrSrnGa8HFzJgBp3IxJvIozwH83w5Z
         DDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h/P3JA46kWkR1ok83p5Cbw7TV2607e8IBxUrOI+c/JY=;
        b=AfSmZEQyMxvq1y/NNvDbPdMMdroMIi5xLNgWDEPsZdtCKUJ1IYJvxSJW7D1fQEL7Mu
         Bs+h8+jEeyj/PXn6t87yAuGwiE5WcvlW9i7y2MvQTcDADGK3XIyGMbT13zfhWgV7xuKu
         wT7h3zyRYYf8xrZA1PEUg15SWrvmRacQSpdf+/RQGZPp1T7hX7zd8AepML1lup0RDXWt
         /UbuNjbwO9ML3jbu3o7DeLB8P7txiqI7UdSppOGmvkLM3fCJYeDDhLkrCzUGjSTbvSPz
         tFNre2OR/B4QQ3fiU6iLB0+ZGw/1sdx/aZx7NtGXcuIFPCJNLvLz7Sxos198Oq5q8grT
         NEFQ==
X-Gm-Message-State: APjAAAVAnbT/7c/r6k1FHiPOLp4X5rkKgUjbg85QuipIvBBxWmf74WXx
        b7prxy1tP5GSoOpFyNgd413c1NOD779y/6vWU/U=
X-Google-Smtp-Source: APXvYqwWRSTsjGSsfAbBn3FBmQk3IwJ5gHMMJQp1jBBJhZxZT6EEM6o0ey+7Uxf6QgNXcqBvjgCmILXp3weYahkWuSM=
X-Received: by 2002:a92:5b98:: with SMTP id c24mr13115016ilg.158.1571255766169;
 Wed, 16 Oct 2019 12:56:06 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 16 Oct 2019 14:55:54 -0500
Message-ID: <CAHCN7xJSz+QhOb4vE6b67jh5jnSOHnw79EyX8RW91TqPkD__Lw@mail.gmail.com>
Subject: pwm_bl on i.MX6Q broken on 5.4-RC1+
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I have an i.MX6Q with an LCD and PWM controlled backlight.  On 5.4-RC1
through the current master (16 Oct 2019), the backlight does not come
on by default.  I can get it come on by manually setting the
brightness, but any video activity seems to blank the screen again
until I change the brightness again.

I bisected the patch to 01ccf903edd6 ("pwm: Let pwm_get_state() return
the last implemented state")

If I revert this patch on 5.4-rc3, the issue goes away.

I was hoping someone might have a suggestion on how to fix it to play
nicely with the iMX6Q PWM or revert if no solution can be found.

thank you,

adam
