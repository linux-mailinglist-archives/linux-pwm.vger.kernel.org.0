Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D64DCC4
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2019 23:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFTVip (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jun 2019 17:38:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42506 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFTVip (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jun 2019 17:38:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so2241246pgh.9
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jun 2019 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FRa+FTYrUwE5FnAqArVG6ocbHw5r29drxK/7hoYzZjo=;
        b=HR7QDXLF7YhGpHGL9vIVq+IKHpppE33n8uKbIEm8UdnyiHhFldKWoErbW86WxynVZB
         4i4L4LrzxDFCh7MvTNJvhtiMin58jW986U/8DoROWF4VPVnPfevCtaZQt8Uzvz6/6rO/
         Hk1K2d4TVRL6un9PVsnjAGfyCrNnmX2DfItpG9GMkMTr5x4akX/6PGZw4KnwFnPL+ZYV
         wjxcI1mC04550rE3GTltks17N66DE4Ys6GexAO14YEFtKdKK0dcZDvOBQa7WLRy/TeoC
         sttTGsNi7ZMpS+09IYY/opogZcAnSmRWR5Cr1Fcm78Cas4Ro+hh/gbHmTxdNE8P3RsvA
         cSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FRa+FTYrUwE5FnAqArVG6ocbHw5r29drxK/7hoYzZjo=;
        b=EdRUhncl+nX5UElyw01akt0OEtOr3oooD7CRv5d1QWxvRYf+hM4FMTppPr4XuPbCLm
         /0Tp82H+8gJZtOrnYe/g4qZys+DuFYeTNkzzrdsEKSL6ImqHjgwTgSMcqEQE2nL5qjHb
         Z0Xx9vl2PQG0fZvSHInjethWqNj2gebNtuYESNw7HgSA3z/m90s1oSPJHUVezlibBz3I
         a+TcDBdGY6QUqCSjZEFcUYMhQT5mrpP7CiyjunGkYjBb45UfaH1tTJqiF7P6vUwNxZ7X
         R+umeuXVszE31OTenUg+jxtOa2IhQ1WPzFWAZqegJDeTZPiiK2VQq5ZBkC2H0fLap3TE
         X2gw==
X-Gm-Message-State: APjAAAVRz0gKICwsR2vDDQ+GU3isOrj7+RqmlkXUGzA18KTTzaYv9eGS
        luxw8jtLyyBenJllelgR45t4pw==
X-Google-Smtp-Source: APXvYqxjVkZc9pYQKXqXmi7Q6qEP+iSI2+ZCxr5esPXxOJPjmPJLRPJUnOC0Vw9lcgMFgHRUh0BlRA==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr74181464pfc.62.1561066724568;
        Thu, 20 Jun 2019 14:38:44 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r9sm542327pgv.24.2019.06.20.14.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 14:38:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, thierry.reding@gmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Subject: Re: [PATCH] pwm: meson: fix the G12A AO clock parents order
In-Reply-To: <20190620144655.2142-1-narmstrong@baylibre.com>
References: <20190620144655.2142-1-narmstrong@baylibre.com>
Date:   Thu, 20 Jun 2019 14:38:43 -0700
Message-ID: <7hy31wdjj0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic G12A and G12B Documentation is wrong, the AO xtal and clk81
> clock source order is reversed, and validated when adding DVFS support by
> using the PWM AO D output to control the CPU supply voltage.
>
> The vendor tree also uses the reversed xtal and clk81 order at [1].
>
> [1] https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/drivers/amlogic/pwm/pwm_meson.c#L462
>
> Fixes: f41efceb46e6 ("pwm: meson: Add clock source configuration for Meson G12A")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
