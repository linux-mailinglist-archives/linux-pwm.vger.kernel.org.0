Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B181EBDA8
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFBOH6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgFBOH6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 10:07:58 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2CC08C5C0;
        Tue,  2 Jun 2020 07:07:57 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n22so919146vkm.7;
        Tue, 02 Jun 2020 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8xPMI/J/UPiXjoWDiiyg6o8zpJPhJIt2b5WwcEF9E0=;
        b=dS1zX8fJi2B1vGF2Z5dg/Gx4V391ld67f0FTyxNDhlDDuArCZJ7dR/CMWc8nQXlkPJ
         6QSmlKw9CzGJ22ICtkEjVn0Ti6FQTkYb+6YkuhnObJfvnxPidiFSz+cpvySh6QYh7UWs
         zv8BeeWiAgBOoeMsb/7vNfOZFhaaPhuoyIOEtu3Fse7SRwZcuXWSa3ebqVjSK+UDEFd7
         nHU/cEShh0nbPvA3oDTELijVKITZR0hj9aUz458PtQlDSbL6jWcqUCU1ZjvPz8Vsdxqd
         pCqhM29P4ETdxzVY28IlXgiBOw8ACfNNAnLYFp4kcQ5J8mf/wjJBm7XfDfELRgRJatxk
         cRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8xPMI/J/UPiXjoWDiiyg6o8zpJPhJIt2b5WwcEF9E0=;
        b=P4MFJ8CtVervWLiC16Sw4kRo4JYz5lwGKATyZ0mymXbfwWnSueihiqjoeRKsAXc0p5
         sexR4Gmu9Sv703/LJBa4A/fwH//l8D/y4OBN/qfk/gcFsl/yEAcyqwAUe/0W6ZJcurRn
         9kJX3DXZp7/Jrc7+8oy4bnnP93+/i3powAXcddjFmMZGLZiyq+PA5MXowKWCIphlwPVu
         AIYU7pRiOHB8Ul4YrWKoyUwl9caeEiQejCOwckTFRyTNmjVka8f8bNjbyxV7af8AIvYs
         JeXI01adbdAijPN8a0nWui72p4kF4H7JoI/5W6enaOZojchME9BI0oc8seR+cykgBiiR
         x+ew==
X-Gm-Message-State: AOAM531N6DEhq4dvVOY1/UbrgktoVrekIWV7AnuI0gOcrfttv4/XxHYk
        goumw+GyBYQHO33EPkytwcnnmEPU0bW+bG+Iq00=
X-Google-Smtp-Source: ABdhPJypGS0oJ4fntkWSo49y5zTssL01yfKEkKGKx4k68oGS4ds8TIfxu0kGhHn0bPQ1u5aluLkGq0H7LniVF+rQA2k=
X-Received: by 2002:a1f:2ac6:: with SMTP id q189mr9323002vkq.28.1591106876436;
 Tue, 02 Jun 2020 07:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200601065207.492614-1-sam@ravnborg.org>
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 15:04:39 +0100
Message-ID: <CACvgo51z0Vvz9LkfqePmuwx19+NhaMEBHe9r5=uYWqhEdnia_Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/16] backlight updates
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sam,

On Mon, 1 Jun 2020 at 07:52, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> v3:
>  - Dropped video patch that was reviewd and thus applied
>  - Updated kernel-doc so all fields now have a short intro
>  - Improved readability in a lot of places, thanks to review
>    feedback from Daniel - thanks!
>  - Added better intro to backlight
>  - Added acks
>
>    Several other smaller changes documented in the
>    patches.
>    I left out patches to make functions static as
>    there are dependencies to drm-misc-next for these.
>    When this is landed I have a pile of follow-up patches waiting,
>    mostly introducing backlight_is_blank() all over.
>
What happened with my suggestion to use backlight_is_blank() in fbdev
core itself?
It effectively makes 13/13 and the above mentioned follow-up series obsolete.

That said, series look spot on. With the documentation fixed (pointer
by Daniel) patches 1-12 are:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil
