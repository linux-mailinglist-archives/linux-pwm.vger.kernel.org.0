Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762E6222688
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Jul 2020 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGPPJ2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jul 2020 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGPPJ1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Jul 2020 11:09:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF7C08C5C0
        for <linux-pwm@vger.kernel.org>; Thu, 16 Jul 2020 08:09:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so11977468wmh.2
        for <linux-pwm@vger.kernel.org>; Thu, 16 Jul 2020 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wfTVEgJCM3Mx2ShOcrbGhi57eh5VniqIcsBsFPVxDMQ=;
        b=JIsaQgcOlfc1snytddMtZoMFDfykhaeqOlXeq1BdwR7CE0s3ZN1P7PART5hVNyrINm
         J4lJuTBjyirv5Vk34La3RjIatruJtd5YCU1nqKG9stWPQjYuQEzH881BV16vzYPK2Dea
         5qy30/h3s7mt5hyCdPcjhM2+sVSQBJN9JZEj4+WGmiuzLLjxBg2FmL9w31SvMo+0v0gQ
         uDlHdi3eeGEntYEDDabA+hvWlsEtCSFhjHCwoSNXIuVEyVu+3UUwuAsHbf9gRSqajAFp
         y2E9F2ieus6X6FgL4sv0Q9V12aGYccH/0nw7kQ1opDF6eIVoJ+/YNwnfdEhsSifamBRL
         YgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wfTVEgJCM3Mx2ShOcrbGhi57eh5VniqIcsBsFPVxDMQ=;
        b=UujFS9nbDiKPEAee655H8hlZSLg4yHXUqd6fVI9S8W2jSxPZRL1Ybfc/e9QWlHBUwh
         smoAIUbBMQ+a+/ljr2ueTMbVOp4tq7Wcm0IZrlmSuvau4bARs6ucJMM2FcDDWXux8y6R
         ns7VIef+dKcotTYfZXh60SEafL6qKh+f1P7TsRARNO+mYkswlHDh1/j9wh9e78jI/Ljw
         nvbzwNa2Y51rhnkFzyjgNSvl1lXTMh7BUcBgDLvZzY4A4gLfMRY3wfvG053dxeWbbi2d
         2FDYr3Bb31tKMWxdb7iQ68mWSHPjyXNymAk0pCq+YPiGZ/OAw8XjpD0nKhBIfrK6/wcw
         NpKA==
X-Gm-Message-State: AOAM5333KZlkEFbvWSt1LQ2iKTY93osbGUpgMyMQqv57/OZAD5O2iWuc
        Quy57CPKhxcoYsld7qxbJBcPUQ==
X-Google-Smtp-Source: ABdhPJwJtZ75Fe6xQKoWPm0JZoQfZmxBLgKksLYrLabK8E2UskeVzYq5S2vTJLxmhzHmqHakCWeJRA==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr4787367wmc.32.1594912165892;
        Thu, 16 Jul 2020 08:09:25 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 33sm10400383wri.16.2020.07.16.08.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:09:25 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:09:23 +0100
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
Subject: Re: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Message-ID: <20200716150923.GY3165313@dell>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-6-sam@ravnborg.org>
 <20200716143941.GS3165313@dell>
 <20200716150021.GA1936267@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200716150021.GA1936267@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 16 Jul 2020, Sam Ravnborg wrote:

> Hi Lee.
> 
> On Thu, Jul 16, 2020 at 03:39:41PM +0100, Lee Jones wrote:
> > On Fri, 03 Jul 2020, Sam Ravnborg wrote:
> > 
> > > Improve the documentation for backlight_device and
> > > adapt it to kernel-doc style.
> > > 
> > > The updated documentation is more strict on how locking is used.
> > > With the update neither update_lock nor ops_lock may be used
> > > outside the backlight core.
> > > This restriction was introduced to keep the locking simple
> > > by keeping it in the core.
> > > It was verified that this documents the current state by renaming
> > > update_lock => bl_update_lock and ops_lock => bl_ops_lock.
> > > The rename did not reveal any uses outside the backlight core.
> > > The rename is NOT part of this patch.
> > > 
> > > v3:
> > >   - Update changelog to explain locking details (Daniel)
> > > 
> > > v2:
> > >   - Add short intro to all fields (Daniel)
> > >   - Updated description of update_lock (Daniel)
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > >  include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
> > >  1 file changed, 49 insertions(+), 23 deletions(-)
> > 
> > Some of these do not apply cleanly.
> > 
> > Please collect the *-bys already received, rebase and resubmit.
> 
> Will do.
> The patch-set is based on drm-misc-next. Are there another
> tree that I should use?

I don't have anything to do with that tree.

Either Backlight [0] or Next would be fine.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
