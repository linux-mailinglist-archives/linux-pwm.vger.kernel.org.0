Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D08E1E06
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392166AbfJWOXV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Oct 2019 10:23:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40781 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWOXV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 10:23:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id i15so8806757lfo.7;
        Wed, 23 Oct 2019 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YH0z87/Zrtz0Lhp/VX5YSi7gAAWFFXFWThfAN9xrC5A=;
        b=IFFUl64IT3oIzJIRHPUwGHNSOvF4UjGGjgVIj2F927PpQjnOSJtaHHqSkV159gwzeu
         AwhKtsmMAN+bp2BU40zR6xwzXFKoA3K2vytfQ8S3wjjquCIYqB04JincfVYAsXGAIjxO
         zN++lodFHzzLxO+ei3Yt3op+Ghnh0zBRyzsjuiWgkdn8uC/h0a1IWmtMSVr+l57qtbP4
         fMxMU6Xcj0hldg+QqKzuwwC9ETSji6noaEgk6U0L65bPa0DpljGY3pY7H2lUB/1cPSqd
         MgoZrqFcfZWZzryRkbaZHzHv7TYoWfx9o3AgkMM/r4EhhRkBBFEeoM8cB74le7zbw1ac
         Wsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YH0z87/Zrtz0Lhp/VX5YSi7gAAWFFXFWThfAN9xrC5A=;
        b=a7ULAQaHR6p/cWbqLAtkmKmn0a7JbSe4PuGflRhNJLJBPU+avmhQPA7ORV99QrTtoP
         T6velRcAPcsGsT+ztOFJPtnxODRX7M2/xKQUG1jT9RrQedWU9Tni1PEO0bwWBYygfNdx
         XVjURxOzQr0SfLdopC8EiQrT27YlrXMGBivZgg7gV1YF5iggCGF6JqcrqXh5bH0XVaBO
         mqeWcJg86snmjJ5hBBWSptiwiRRzAEgTjVc2TLG7fz+/LhEjK0mBZcdgJ6kcRHiF2Dck
         kKeQk5nITRxREYKYqTbVX+QyflVMPMxyBMQudZX8ZNhEMvdDPqlUT2XGodyyBiOpQVCl
         QzQQ==
X-Gm-Message-State: APjAAAWO0TAFrHF6SelMZbQ92eHLbXhhZJcc8WbA1OLTlAHRhM6q5yjG
        BdHsapRc8ZMuqhfqvRw2EIge5MhuucZMHL/nlM4=
X-Google-Smtp-Source: APXvYqzp6mMJKGG2NsuDu7fFREGtRLh/esmNHeuaAFC2lZsYWFDi3jPGmJ5h5h6sH0SLYyoa0JDTSQUh7r1Hkp6Z3Rs=
X-Received: by 2002:a19:4318:: with SMTP id q24mr8343971lfa.12.1571840599375;
 Wed, 23 Oct 2019 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <c89925bd-857d-874f-b74f-c5700d4c9fbd@ysoft.com> <20191017101116.3d5okxmto5coecad@pengutronix.de>
 <20191017111131.GB3122066@ulmo> <20191017120917.fcb7x4fq4tbl2iat@pengutronix.de>
 <20191017125932.GB3768303@ulmo> <aa73b430-527c-8066-ad9c-edab62a05fc9@ysoft.com>
 <20191017151437.GA85210@ulmo> <CAHCN7xJduG9yxAhuW6D1_kpd5=p7LhO_YCWjVxcCoW5bmSEJGQ@mail.gmail.com>
 <20191017171326.GA531411@ulmo> <CAHCN7xJWco5gTdjmJZRbNqi1aO+ytor5XMJWQX8a38tfGbz+xg@mail.gmail.com>
 <f6d2427d-21fe-e89c-0bfe-572bc1d00863@ysoft.com> <CAHCN7xJJH12sdeLb97OutJqThv+TzMaNj-Y50_C9G7UgEQCbxg@mail.gmail.com>
In-Reply-To: <CAHCN7xJJH12sdeLb97OutJqThv+TzMaNj-Y50_C9G7UgEQCbxg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 23 Oct 2019 11:23:11 -0300
Message-ID: <CAOMZO5AgUjA8eSNVM_rKi-7NAX8hj039STcJ4Ov4w-0m4WTf8w@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
To:     Adam Ford <aford173@gmail.com>
Cc:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 23, 2019 at 11:16 AM Adam Ford <aford173@gmail.com> wrote:

> What is the plan to address the regression for 5.4?  I wasn't sure if
> we're going to apply the i.mx fixes or temporarily revert the
> offending patch, or something else. (or maybe nothing at all)

Yes, I do see the regression on a imx53 board with 5.4-rc too and also
interested on a fix.

Thanks
