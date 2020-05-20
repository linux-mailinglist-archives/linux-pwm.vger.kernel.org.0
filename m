Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E848E1DB082
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2020 12:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgETKsD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKsC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 06:48:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C88C061A0E;
        Wed, 20 May 2020 03:48:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a11so1065984uah.12;
        Wed, 20 May 2020 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg81YZ11MbDWpDXKxv66z4ejnYYlm2/xxGtzMeNWMhs=;
        b=EMX7fQn5U3srepsHrkjbIB4aWoXbUaophu0U0Omos66kObg0me9Vb2mytHaA8Kkrhz
         QyF0umb1bVg2R6vB61kXI1IDombYO7Esbf/IiUxQMM+6F2Ryh3zlAypWQkWKXSaWRhYX
         dBRzY/8233pbRA3dglQaRI+shDReW0lVD6k/7JwYb97vrYfruLlv5okhopvDLX2wm1VG
         gWeQVWargxsulPTFVjRN+30nSrzOSNYW7VdoeTcGY6OBvlINFfDXgAMlnm6QIefBSd83
         f0gPW84VfRjvmAukxAnBSY0F3fsfoHelOSS0Iwxg6ZiZFMVHpP/XrZLKNzKMRsGXGXgn
         sTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg81YZ11MbDWpDXKxv66z4ejnYYlm2/xxGtzMeNWMhs=;
        b=fNvyo4Np+GkIoLhv2boSs0m5L6bSEjUkTAQtAJImjHoX0dgtvcPN1yCcRRXPpYtmMi
         3+4Ak0oA36ero7bb/P2cye+pR7yeu0whQqj9Jrd98hYC74h2sVXve+yBLSJB9vtt9E8J
         rIiUMnmD80eh6+ymSqiPQTt3a0ZxK1fEgI79lcugI+JtO7xzzQowPtuN3vJ6eztCbJLG
         u72rrR1oVQUsLPOXHk0VQCosLc2LqX+PEAqDUtqhNF+4rc0/X2hv/NyrxLt6PQIoq5Gd
         r/LDVHED1SNL8BViSUyvCawMKIjyuKQ0g3drX5ocGgL8jDAmh7Avud35fu/hTqOE/s49
         JSuQ==
X-Gm-Message-State: AOAM5326YEvmwTvWiCyVFU/iyS4CdGdFw2BMVW4OXQE1DB1PnJ80+feq
        EOmeJcVoJ48Z78GAJhpQ70DM1FzSEoAEoE3Nm5M=
X-Google-Smtp-Source: ABdhPJxKtUis9QH1uXArzW66ACDexrbsCIO0BhIGEmcFEix0kbYyKDeCpt2ONtofmkZIVMY1POgJJo3lOB4rcz0R9AY=
X-Received: by 2002:ab0:b93:: with SMTP id c19mr3023403uak.69.1589971681089;
 Wed, 20 May 2020 03:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-4-sam@ravnborg.org>
In-Reply-To: <20200517190139.740249-4-sam@ravnborg.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 20 May 2020 11:45:06 +0100
Message-ID: <CACvgo52AegdsmfOsVoTHH=oporeMMV8bShQMJC11JiO5bNXwrQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] backlight: add backlight_is_blank()
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-pwm@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 17 May 2020 at 20:02, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> The backlight support has two properties that express the state:
> - power
> - state
>
> It is un-documented and easy to get wrong.
> Add backlight_is_blank() helper to make it simpler for drivers
> to get the check of the state correct.
>
> A lot of drivers also includes checks for fb_blank.
> This check is redundant when the state is checked
> and thus not needed in this helper function.
> But added anyway to avoid introducing subtle bug
> due to the creative use in some drivers.
>
> Rolling out this helper to all relevant backlight drivers
> will eliminate almost all accesses to fb_blank.
>
Nit: please tweak your editor to wrap commit messages at 72 columns.

> v2:
>   - Added fb_blank condition (Daniel)
>
I was going to mention this, but Daniel beat me to it.

Please add an extra NOTE in the commit message. The fb_blank is a
behaviour change, albeit in the right direction.

-Emil
