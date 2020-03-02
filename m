Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD281175CDF
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 15:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgCBOXc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 09:23:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36411 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgCBOXb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 09:23:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id j16so12863890wrt.3
        for <linux-pwm@vger.kernel.org>; Mon, 02 Mar 2020 06:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yonDHdolWIn4SkNmhlWY3OpANSyLF2GFYrxdHSqeb9w=;
        b=QvDQCiU/yurtIg2JwzVi0YpwzRuFU8FubtbkpGmE2n7WqnSj+hf9tgluwRK/k/cKiW
         vXKVsSg1+rQxejo/pYFnHp29/+7mkl6IWY7bhnGiCkchBa6IdwSoB1BKPoCF3ODhGigh
         D8pscJdUblkW/z9EXAas93wLsX2c//xvse2VevDfxtUI5hnInCwH0VUDuCaE5g8esAY1
         9iMOmr9DAt2fqerGCi08uCYIm3ce0DNkE2K/tdFxcfRqVKheOMgWYjz4p+efrPfyxLpB
         qWkBQGgKJ2+rcg6WeJmAoCUGqll0n1+KsCStNG2K6coxHyJRhzh0l8LaNJ5UjckNpTlx
         V7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yonDHdolWIn4SkNmhlWY3OpANSyLF2GFYrxdHSqeb9w=;
        b=VarYAyi7bc2p71ytzVvlUDXtZQaqE4UrD6CBdHhEjxmeE7nzBqqY2ajkXTieGOVBTp
         9358G+ub6vvDTrdENsUTksem97CnEojdwaIYCmmAvKBQPXX+VLx9A+AD1hQjtSElSUqZ
         PpYqDJRYu+6lVDrxBYMIXzzAzWY5J0zts3HCcn0g5BF/iE/ivdZSO/EzraWb4Wf2+NiF
         WxL61nBzmHptHQbz4zNn/8KDDRw3sYxFMbIY9UwNKrxw5bZe0k+j5QDXUdVs37qCVVI+
         uOe57l2qdVqcR5tMkUFfe7qoXCZuZEHTrDSyzMZP9K4piDkcKSads4ofE3/ZsLJUDbOR
         OvEg==
X-Gm-Message-State: APjAAAVCaJeR6nqBQ7s4yivNwbZlH/my7DOYieTe3gTT0LOHV/wMr1sB
        H9vlcPI1XO272Mdiis4O0Oje3A==
X-Google-Smtp-Source: APXvYqwVggDQ245XI7AoDjZd00PfYJ6yqqfBMylCMd3P7eml55z+AJsZT6lp0LjvWqaJ5MfjypJrog==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr22348852wrj.196.1583159009498;
        Mon, 02 Mar 2020 06:23:29 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id a9sm15947351wmm.15.2020.03.02.06.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:23:28 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:24:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200302142405.GA3494@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
 <20200302120458.GY3494@dell>
 <20200302141117.GA11787@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302141117.GA11787@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 02 Mar 2020, Jeff LaBundy wrote:

> Hi Lee,
> 
> On Mon, Mar 02, 2020 at 12:04:58PM +0000, Lee Jones wrote:
> > On Thu, 27 Feb 2020, Jeff LaBundy wrote:
> > 
> > > Hi Lee,
> > > 
> > > On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> > > 
> > > [...]
> > > 
> > > > 
> > > > Well done Jeff.  Good job.
> > > > 
> > > > Applied, thanks.
> > > > 
> > > 
> > > Thank you for your kind words as well as your support in fleshing out this
> > > series.
> > > 
> > > Just to confirm, does your offer to take the remainder (once everything is
> > > approved) through immutable branches still stand?
> > 
> > Depends how quickly you can get the other drivers turned around.
> 
> With Uwe's approval from Friday, all five drivers are complete. Dmitry and
> Jonathan's approvals were given in previous review cycles and were carried
> forward with their permission. If anything else is required, please let me
> know.

Does Uwe's review mean that Thierry's is not required?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
