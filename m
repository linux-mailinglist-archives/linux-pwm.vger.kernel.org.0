Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE2197CAF
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgC3NSb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 09:18:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgC3NSa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:18:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so6698161plr.11;
        Mon, 30 Mar 2020 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpPeW6G2qjoJofkcYoqKuOcgwl22A0kdmIAYtTVwHBU=;
        b=RmRKKD1HMyvZ+ORvnC1mFm7k6si47qOlYhWFtRVC/RTL6B4XzpXYJo0FLvgVv6Zspp
         gLJK+dW4DxJDHInWaTI9oIHNsDjYE94NrDiaEDCaOo1vaCM1cOJyeb08E4I/hyhy4sjD
         muSi5R/C0Oa01ftWuiF07B5VSHnYZmXxIaIekpNjIhmkCGTumUTMpPj5ACzHRP3mSbb9
         JFrXweB+UjYaR0gA+35pFYGwvZethoZxdyNIebDyry0SpUpGRi0lrwhtGTnYeJBRKSUs
         SQ0Ich49FAW7DK6COzhV07zCAYkHnaP78wTRU5TJkyMnQ3E+RXyQe8ThaTKTq9K29coj
         6y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpPeW6G2qjoJofkcYoqKuOcgwl22A0kdmIAYtTVwHBU=;
        b=AQ1u2A9Uyhxs9nHfpdLjw2VLNfdhpMVvtcXPMatKcenbd8+esN1wD+YJAwwni1DEfv
         u6P2ITNFdHcK3sjgS56KzeMNDYqdU8QMfsSMfL85FlHSd54HehoFx6+OZa8Zo9mvJzAY
         V2lg47GWqGN+nFNJU6l5aFmmSe5DdR4rHHDhnkaB/BGPjNNX1gLkFcIdz3kDLZF1yCzA
         Ydnn1aJ4B0U++XJGY7d1TKNaqW09h9rATdNIjzclPuwHrovNAxUrqVbzHuo2S6AvOqJb
         oLblGDLfel1Ti6IlLB9qffJqiKrBOwTw25Wg2lAlu2KZepv2+wc2q7MyXhl+JvPyHnLs
         w2QA==
X-Gm-Message-State: ANhLgQ2Wx3G26dWgD0nNEOI0+XHB5/0NLgQSzJdNVcuVvuaDFsJO9z3j
        llcfHoMHsOvygcxtoC5lORpp+IZVIS8Hha2znH0=
X-Google-Smtp-Source: ADFU+vtVJXrtiJfDPKD9q4R5bbQ451QL4TNI1kjb+yICODZHvYd5OMlyLdx6yEz2heeTtPKWqJtheMt7ptNLToIDVKk=
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr12921496plm.18.1585574309464;
 Mon, 30 Mar 2020 06:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com> <20200330130743.GB2431644@ulmo>
In-Reply-To: <20200330130743.GB2431644@ulmo>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 16:18:22 +0300
Message-ID: <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> > duty_cycle was only set, never read.
> >
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 4 ----
> >  1 file changed, 4 deletions(-)
>
> Applied, thanks.

I'm not sure this patch is correct.
We already have broken GPIO in this driver. Do we need more breakage?

-- 
With Best Regards,
Andy Shevchenko
