Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB971424A1
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 09:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgATIAM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 03:00:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42949 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATIAL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 03:00:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so28318144wro.9
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jan 2020 00:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MfuL6BqlY9EL8BEnsX5fv65JIP4/kcoSTzU2TVafC8o=;
        b=Ji5Kp3qac5rK+dk4oGVu9H0nQJK5nlx5Me5oL81WYCb2zGtZN/vSxMGDE447PZ/OZf
         IbG1E3IjKMV/eULv6j2e0s0zo3/ppkcIzDeWkq+H2Uajzh4IV4AjNDdgbu32OhARhgBg
         ETztA5v3PPPQjWUi8iBDs7PpyOZBXG5tY3TOLF2fUSLPRpWHsbH8G4yzxdblUiLephEk
         6UfSPyLHcK1c8V//Jt1d6rz49Va596DpnssENjQRUGE98dBIDCvxYkfeoOpyGWUwiPFY
         8CrzGUYqj+KSQf7N+DddgMCKdu1U6GWOfnbHZtCZVrwMKyLs+GnUGA4r71mBPJ/r5nIU
         Po5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MfuL6BqlY9EL8BEnsX5fv65JIP4/kcoSTzU2TVafC8o=;
        b=DY/m5stpsSTT4Iwcn8rin+5mlBnS1OnsjQicgLE2PgPKNibZ52XPQkqs3VUmt6esai
         P9r4D8X0Ulb3izQ1rkHp3ePx0nIovEPmmhkRPw3PmfvqkQdln3qiFltSW/ACfVCXhlPS
         TTXeoR42tUfXCVx3W8NsRNQYmM1C9MOLWWWdnNmRz2d5CYYIuZSfhZEcgoaol7quD/Hi
         VhBTJ3eCkRUOQCO0zCQMRpxofSMk0q3I4+XU1LCj/IP1osXlBmyyGq7YueOzk9/pjQna
         fHtiD14c+iUQp23d8gkrB03YjE05fc13wyZNW9ksTZXMX+nstusIHxa2lu8Vx1l0VTVg
         gxAw==
X-Gm-Message-State: APjAAAUQPkaCRdeM1hQ9BOfvWKAE3KKsF9b2J4NqMA6h85Ey0UY87l/G
        iA93qDKEHMhhIvyCCdHVdoDdTQ==
X-Google-Smtp-Source: APXvYqz2ucJXStRlD+7VmrbMk5Dz+tYnaocAv6Y/icPKXH/Bi2LQWUG43izVO8TogblaWw+PjwIbeA==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr17556499wrw.25.1579507209626;
        Mon, 20 Jan 2020 00:00:09 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id x132sm7469683wmg.0.2020.01.20.00.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:00:08 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:00:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200120080025.GP15507@dell>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-3-git-send-email-jeff@labundy.com>
 <20200117132143.GK15507@dell>
 <20200120042303.GC28865@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120042303.GC28865@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 20 Jan 2020, Jeff LaBundy wrote:
> On Fri, Jan 17, 2020 at 01:21:43PM +0000, Lee Jones wrote:
> > On Fri, 17 Jan 2020, Jeff LaBundy wrote:
> > 
> > > This patch adds core support for the Azoteq IQS620A, IQS621, IQS622,
> > > IQS624 and IQS625 multi-function sensors.
> > > 
> > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > ---
> > > Changes in v4:
> > >   - None
> > > 
> > > Changes in v3:
> > >   - None
> > > 
> > > Changes in v2:
> > >   - Merged 'Copyright' and 'Author' lines into one in introductory comments
> > >   - Replaced 'error' with 'ret' throughout
> > >   - Updated iqs62x_dev_init to account for 4/8/16-MHz clock divider in start-up
> > >     delays and replaced ATI timeout routine with regmap_read_poll_timeout
> > >   - Added an error message to iqs62x_irq in case device status fails to be read
> > >   - Replaced sw_num member of iqs62x_core with a local variable in iqs62x_probe
> > >     as the former was unused anywhere else
> > >   - Added comments throughout iqs62x_probe to clarify how devices are matched
> > >     based on the presence of calibration data
> > >   - Inverted the product and software number comparison logic in iqs62x_probe
> > >     to avoid an else...continue branch
> > >   - Changed iqs62x_probe from .probe callback to .probe_new callback, thereby
> > >     eliminating the otherwise unused iqs62x_id array
> > >   - Moved iqs62x_suspend and iqs62x_resume below iqs62x_remove
> > >   - Eliminated tabbed alignment of regmap_config and i2c_driver struct members
> > >   - Added register definitions for register addresses used in iqs621_cal_regs,
> > >     iqs620at_cal_regs and iqs62x_devs arrays
> > >   - Removed of_compatible string from IQS622 mfd_cell struct as its proximity
> > >     (now ambient light) sensing functionality need not be represented using a
> > >     child node
> > >   - Dissolved union in iqs62x_event_data to allow simultaneous use of ir_flags
> > >     and als_flags
> > >   - Removed temp_flags member of iqs62x_event_data, IQS62X_EVENT_TEMP register
> > >     enumeration and IQS62X_EVENT_UI_HI/LO from iqs620a_event_regs (thereby re-
> > >     ducing IQS62X_EVENT_SIZE to 10) as they were unused
> > > 
> > >  drivers/mfd/Kconfig         |  13 +
> > >  drivers/mfd/Makefile        |   3 +
> > >  drivers/mfd/iqs62x-core.c   | 639 ++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/mfd/iqs62x-tables.c | 438 ++++++++++++++++++++++++++++++
> > >  include/linux/mfd/iqs62x.h  | 146 ++++++++++
> > >  5 files changed, 1239 insertions(+)
> > >  create mode 100644 drivers/mfd/iqs62x-core.c
> > >  create mode 100644 drivers/mfd/iqs62x-tables.c
> > >  create mode 100644 include/linux/mfd/iqs62x.h

In future, could you trim all unnecessary parts of the review,
snipping out all of the parts you agree with, leaving only the
contentious context please?  It saves an awful lot of scrolling on
behalf of the reader/reviewer.  Thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
