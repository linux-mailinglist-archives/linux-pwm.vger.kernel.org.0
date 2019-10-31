Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53F3EB762
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2019 19:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfJaSmV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 31 Oct 2019 14:42:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37358 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfJaSmV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Oct 2019 14:42:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id p13so3081347pll.4;
        Thu, 31 Oct 2019 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mOGUK5o3jF1p1Y2eIo51S/GjvyM21GlwSNR8PmNMiXg=;
        b=D8Qe+GkSEbF2UB9zOoTJWhjptWn1t131cSjAdJUZz3AWWUmB+ldbx8F4TVpr4W2eeJ
         3qg51Bq9dLt4pMg0LP12DX4fm/rrQYuzDsKjUGe2HKkLdsxgXe0mpzjbDVdiq3F1d6+p
         dA0T1xjazLrxLpKZaNsOpCzhqHzARInzRY3cYxkECjdPrmCCnkc+F629Yd6MqK6u8xT7
         x1aUrlOPl1Ek3N3AmeglBq745U1VvC7tDapMcijOlMpTchBKBU5BKyHbbgcui4ZxKoj4
         rTNcG4rm9PAcEM6rPpo408uIztWOGckiKOfI09SmmArWhudXLnEph9gP4i136EFlAh83
         LEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mOGUK5o3jF1p1Y2eIo51S/GjvyM21GlwSNR8PmNMiXg=;
        b=YoIVqpnai0NHuMW8IQZUSbN9GIwGFx+SQd/tV3TT1kblxflddkHIEEV8NQRggPps0P
         4wScIEBjEhMrAcrkf4Dk7CRuhrYafZZgZ/kWTVRzNjyL68dpnRRl0zBXLWvFwE2EGPjY
         l6iBILpbVd6knql2ap29zjNbXvq9ckjTxUdzqoePprVDxF9rXiDutiFgU4WccpfN0iJm
         Y3pI8zI8jFUJkCNOPEpz6W6R+rbLFUb551HgFRvM6IJm30OKyMVfIDT/+tVDR2s4O9p7
         pEw5K/KhR8TwU1Fqo4wWzT6PVCxIQE013ZE9pTuontPtf1RWIX1f/YDwJu1P8u09chPH
         551A==
X-Gm-Message-State: APjAAAWqJVYuR4QJbDiri6LOI/F2pxgYgdb5GlnEwIJHmF0viEfcghBx
        7EZ390980AveBrCqBd44+gCAzOjz
X-Google-Smtp-Source: APXvYqyME+Sr4dcNOEyJBsn6UMyFA0KQ9xeaxpAN3OCNXOwcpprTSYjBoKHAdoUZqydVO8s2oHdweA==
X-Received: by 2002:a17:902:8305:: with SMTP id bd5mr7943187plb.184.1572547338232;
        Thu, 31 Oct 2019 11:42:18 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r11sm7567137pjp.14.2019.10.31.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:42:17 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:42:14 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jeff LaBundy <jeff@labundy.com>, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 2/8] mfd: Add support for Azoteq IQS620A/621/622/624/625
Message-ID: <20191031184214.GL57214@dtor-ws>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-3-git-send-email-jeff@labundy.com>
 <20191031134410.GB5700@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031134410.GB5700@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 31, 2019 at 01:44:10PM +0000, Lee Jones wrote:
> On Sun, 20 Oct 2019, Jeff LaBundy wrote:
> > + * Author: Jeff LaBundy <jeff@labundy.com>
> > + *
> > + * These devices rely on application-specific register settings and calibration
> > + * data developed in and exported from a suite of GUIs offered by the vendor. A
> > + * separate tool converts the GUIs' ASCII-based output into a standard firmware
> > + * file parsed by the driver.
> 
> This troubles me somewhat. So here we take a C header file which is
> the output of a vendor supplied configuration tool, convert it to a
> bespoke file format using a Python script authored by yourself, which
> we masquerade as Linux firmware in order to set-up the hardware.
> 
> Is that correct?
> 
> What is preventing a very naughty person from providing their own
> register map (firmware) in order to read/write unsuitable registers
> from kernel context for their own gains; simply by swapping out a file
> contained in userspace?

How is it different from, let's say, Intel WiFi firmware that you load
into the kernel and then into the card every time you boot up your
laptop?

Thanks.

-- 
Dmitry
