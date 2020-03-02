Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF21759F2
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 13:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgCBMEZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 07:04:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50573 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbgCBMEZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 07:04:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so10883172wmb.0
        for <linux-pwm@vger.kernel.org>; Mon, 02 Mar 2020 04:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LfwHBF+1G3/DK1Sa/fxKynvnskOyWmgOn43G66JuuXg=;
        b=fJsoGkY66Y+OGJcqLdZCFSg2SEwEJ5bMmGoYoNjlCGPFA1TJKDS5CosrXav6DjtawT
         YZQSyHU8kThF342vvA4c6n8b5oSXIfH5BzLS9T6rwV0s61QDV+vUYr/KozQ8ZKKLE8mQ
         /vR5oDePM6lxDYnfsQiZQg1fScIT0dKeLkw9rwSscm0W9j6mcX6jUvpdZ0zC9CXV+3v1
         hofXleOlfL3zDrk1tpmFkeRCXYaboRfbceNBVBugoL9w6hB/+mMHIf6UnburM8FBaOSg
         ei7g/pxeh3OkZPwnY2LoRgm/aqeqPouwI3tsmDyZZZ8xFRLAMMIAEVL5KzGuOXM6jXtP
         CR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LfwHBF+1G3/DK1Sa/fxKynvnskOyWmgOn43G66JuuXg=;
        b=gl5RoLjilv3ZffVP1zRnNOyug6xaq4bSVE8IumCjtSyzmyASL6YjYUeLcmIVwYI85C
         WMg4Tyl98m2ukdaR/oldm4d6IxSto6Mh/ZC4et2YiV36eARhJ27f4RQ/8cY1DCQpOYN3
         ucn7UyTLZREf2F3cOYwJgNfqeVoZVsiBgL7GGwOfTuSN/Ze1UtZ2WI5K0COZnx9Ypi1Z
         HhfrapETnsHHDqb7TB9a7VnxOoDKUGE65T4q6wqnceVC9KTUIebCUzvbv+77whEIkZ09
         SCQVd6kNWOzZRT4cKp7cW7JdQr4QgwKx0FLwMhPCjifOT++loeouTQRc55EaGjvlLofj
         0RZQ==
X-Gm-Message-State: APjAAAUrbRX0ojz6Fg0RDKzJ52S49p4MD7bVrikSv5ncdu+6zfFXiaM9
        AJmtE7Bkr4PGou7qBiBKDqZk7w==
X-Google-Smtp-Source: APXvYqwY7JNdGcibXu8arbodj+Ox9DFMTorii9SxoGFb+i/waE0uuBxRdi/Lb0LYg2yCgoBDixUQvg==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr19983737wml.72.1583150663296;
        Mon, 02 Mar 2020 04:04:23 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id v8sm27192427wrw.2.2020.03.02.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:04:22 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:04:58 +0000
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
Message-ID: <20200302120458.GY3494@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-3-git-send-email-jeff@labundy.com>
 <20200224111448.GS3494@dell>
 <20200228034220.GA3510@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228034220.GA3510@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 27 Feb 2020, Jeff LaBundy wrote:

> Hi Lee,
> 
> On Mon, Feb 24, 2020 at 11:14:48AM +0000, Lee Jones wrote:
> 
> [...]
> 
> > 
> > Well done Jeff.  Good job.
> > 
> > Applied, thanks.
> > 
> 
> Thank you for your kind words as well as your support in fleshing out this
> series.
> 
> Just to confirm, does your offer to take the remainder (once everything is
> approved) through immutable branches still stand?

Depends how quickly you can get the other drivers turned around.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
