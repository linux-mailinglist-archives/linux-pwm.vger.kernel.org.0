Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE242273B70
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgIVHIy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 03:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbgIVHIx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Sep 2020 03:08:53 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403EE23A1E;
        Tue, 22 Sep 2020 07:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600758532;
        bh=Q9EIerF2YpUp4pwyWgck/zaWlyKSSyBy1o2vS+YkpDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yLaNCV3E1ni8PMWPJKhZHUP5zyH9/RIGelJRkhz0XnXaoRSXGqrVYlGa0h+1p08wj
         HdDbxtzf7mwTjYGAOiSG1Iq/iO3UwI5pvEaiJD8F+G7WAMD//GA1WuWb8TLttRJNWO
         rbgd3Rs+Si3uwTfnnPpxh3Rc9JzaXSGwbSJQ+2HY=
Received: by mail-ej1-f52.google.com with SMTP id q13so21254299ejo.9;
        Tue, 22 Sep 2020 00:08:52 -0700 (PDT)
X-Gm-Message-State: AOAM533no99YWwAw10XMK+FpbGbhm4KDQ76GbNDv3XenSYz9Npnv52eE
        Nhrj48JnVBjKUUJA3sfJ2x9kkAgxcR8TjbM0H14=
X-Google-Smtp-Source: ABdhPJz5Bpo4sLZx+VgODKy1nNTRF0OkATsG2D8nukSvGgRjPsORZPEEbE8mlh2UulqYR1jQq3wGmko6aeeETpH/EZQ=
X-Received: by 2002:a17:907:724f:: with SMTP id ds15mr3277198ejc.119.1600758530722;
 Tue, 22 Sep 2020 00:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200921210233.21449-1-krzk@kernel.org> <20200921210610.GA5338@amd>
In-Reply-To: <20200921210610.GA5338@amd>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 22 Sep 2020 09:08:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdwQc86H-S=C4v_1VCbd7RhC2Soepj_2LqG1e_E_bgAug@mail.gmail.com>
Message-ID: <CAJKOXPdwQc86H-S=C4v_1VCbd7RhC2Soepj_2LqG1e_E_bgAug@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move Milo Kim to credits
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jonathan Cameron <jic23@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 21 Sep 2020 at 23:06, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > credits and remove the separate driver entries for:
> >
> >  - TI LP855x backlight driver,
> >  - TI LP8727 charger driver,
> >  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> I believe normal way would be to mark the entries "orphaned", not to
> drop them altogether. Plus, I believe someone from TI is likely to
> step up.

These are entries for specific drivers so they are covered by the
subsystem maintainers. You believe someone will step up, I believe if
these were important for TI, they would find the person some time ago,
so the emails won't bounce... This was similar with BQ chargers where
Andrew's email was bouncing and after a few weeks it was fixed. To me
it looks like TI does not have any priority in maintaining separate
driver entries so what is the point to keep orphaned driver-entry? It
is not the case where we have an orphaned subsystem and we look for a
person to handle it...

Best regards,
Krzysztof
