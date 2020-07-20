Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199F6225BBE
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jul 2020 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGTJgG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jul 2020 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGTJgG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2020 05:36:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D7C061794
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2020 02:36:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so17097152wrs.11
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2020 02:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zd3hMZ6jTMVpvEqLVZwEN55R94PoroeJHFEcHCEFqVQ=;
        b=kTBBVlsC9e43rf09etp8fCt18Y3wM0WlVE5CwPvXkNHO2U4nUHW4UZ67UA9ckbRY33
         TnSE0eP0Zthv72OZWg8OZ5FI9VF80Ctv4yb0QT/+s2vJUCPYEPYl8IgxUFIxtO61pXzS
         mM/+YActrKyhNVy/5SEC4JLG3KUkTOopSiOYVda/q16drbWQJ3KM99jOyXVoS5d+XlNg
         hV1rSkIf943RqBKh7q0QojJdfGt2vk3CWXUKByU7OGBfSxaXLQKDaViD2TNyr4ZJO2js
         iBdb0w1YxreRKEsvi4vuL5tvG+Vk2psa8N/bZHmrhy+CBbcXdc59kNMRQz6rdGOPT8qr
         TYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zd3hMZ6jTMVpvEqLVZwEN55R94PoroeJHFEcHCEFqVQ=;
        b=ZQWrzn+G4fjvB99x05tcKYC909Ap3kojRyYf1GxiOUVK0nxfmlErRiYB0ZluRkoVso
         zzY2QEqgwUlSK6i4HKKTgaWHYSWXIiHPlFHmgyMuTq8lA+diYoydORsr8s4Mq7UYvxM3
         ZkY0f3eG/NFmmaSOTCCi4B0P/sP1M3U9RHGmYIIymgJYdyLCl2pLEBrlaT94mXeACfiP
         eoD0jAPBwcWlyOG32ZL8T9OeM+fM0kYJp2ZtWLP4ifRIcBMzSd6ZoqkfOe1gV2DncEGj
         DvX1eeXdynUYxoM5WzRYH9jqtVfO1ULDW018Ml6Z9uvZ+OwN6pbviioDYGjilHJwrHac
         CmPw==
X-Gm-Message-State: AOAM530G/NqSq+Y6WaX7cj7iuaSPr9XVkK9eVUdHbaQLg6ZIZanSW6f5
        Xx2SSvRqoLF7ieYUtrrs2JkAUQ==
X-Google-Smtp-Source: ABdhPJynB4npHFycjyW7pEMsYdT+xIjEXcJnZnCF1NpojzzkoEJrVaNiN9teoC2u+pkXJtweZXlzbQ==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr23265244wrl.292.1595237764811;
        Mon, 20 Jul 2020 02:36:04 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k14sm30904848wrn.76.2020.07.20.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:36:04 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:36:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
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
Subject: Re: [PATCH v5 0/19] backlight: backlight updates
Message-ID: <20200720093601.GA3368211@dell>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 19 Jul 2020, Sam Ravnborg wrote:

> Hi all.
> 
> Follow-up on v4 - with only a few changes listed below and
> in the individual patches.
> Thanks for all the reviews and the feedback on the patches!
> 
> I am planning a follow-up on this patchset to update the
> backlight drivers all over to use backlight_get_brightness()
> and backlight_is_blank() as appropriate.

[...]

> Sam Ravnborg (19):
>       backlight: refactor fb_notifier_callback()
>       backlight: add backlight_is_blank()
>       backlight: improve backlight_ops documentation
>       backlight: improve backlight_properties documentation
>       backlight: improve backlight_device documentation
>       backlight: document inline functions in backlight.h
>       backlight: document enums in backlight.h
>       backlight: remove the unused backlight_bl driver
>       backlight: drop extern from prototypes
>       backlight: add overview and update existing doc
>       backlight: wire up kernel-doc documentation
>       backlight: introduce backlight_get_brightness()
>       backlight: as3711_bl: simplify update_status
>       backlight: cr_bllcd: introduce gpio-backlight semantics
>       backlight: gpio_backlight: simplify update_status()
>       backlight: jornada720_bl: introduce backlight_is_blank()
>       backlight: use backlight_get_brightness()
>       backlight: drop backlight_put()
>       backlight: make of_find_backlight static

All applied, but to be honest, that was quite painful.

A few notes for subsequent patches.

 - Enable spell-checkers in your editors
   - I fixed the issues up for you here - there were quite a few!
 - Run ./checkpatch.pl before submitting - here's what I find useful
   * .git/hooks/post-commit: https://pastebin.ubuntu.com/p/WpPFd6M2rB/
 - Please keep the in-patch changelog below the '---' line, so that it
   does not end up in the final commit log
 - Cc: lines *above* the *-bys please
 - Cc: lines dropped for any *-bys provided
 - Lines wrapped ~72 chars (not 50)
 - One whole empty line spacing between paragraphs
 - Ensure you use the formatting expected of the subsystem - in the
   case of Backlight it's:

     <subsystem>: <file>: Subject beginning with an upper-case char

   A `git log --oneline -- subsystem` would give you a good idea of
   what's expected.

-- 
lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
