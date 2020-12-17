Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385DF2DD5BC
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgLQRLD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Dec 2020 12:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgLQRLD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Dec 2020 12:11:03 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE66C061794;
        Thu, 17 Dec 2020 09:10:22 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id q10so15314492vsr.13;
        Thu, 17 Dec 2020 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVWkc2hjiETBBpFaxuhkqsl8mzCX2jQxdE5JeIF+Z0Y=;
        b=CU6N4d/bdV4lyjdny521D22gA6ha4lMOfjgVpiPKJ8cMTUupgq9lg2BLsv/0ob4fZz
         zIjU7IbSh/CpQNNeeFgtoC9UPiGcGRQhByluuO5UdxUhL4FUhL9NyVbrK5mi04J2HZIB
         vXbjyjQo36hd33+JYsD41DBMtoBY1yQ5gsO+xKZmFmJQNCjTINeOBYRrv70HQrUnbSeh
         tdX3bYRKup0qyB0DuczCDf9aPYw3SuXTJ2LtRkunrm8HE1gr9eyLdEJPvLy+mRNhVsqM
         lJhgBPbZQuE8QWYKYf/qL58Vn+kbXVAK8hFZU0ugwwUJ6Mi/LkrOPgPyPqi4nbaLX/n4
         or5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVWkc2hjiETBBpFaxuhkqsl8mzCX2jQxdE5JeIF+Z0Y=;
        b=Lzdv+BJBUAUyOMCQcP3Jy43IZw3yaALgF0OwH/3cS85zr8DXILZatWpzS2u3/OTDMK
         zJfmNFhdP3edFYBev7MlSVjRPl0QA02gIOCMS/Od5t61i0dOGe0KSv/TE368J1G6R2hv
         0S7Vk581/gSW2XGstA6FZ/pWmyKNs2B81uDBimcpDbC6EMLgyFQcq8Av7Y4neUJyvMCF
         P8DfKvbBykmGCxUqDZbTPD8j3AyVTzANbhwx+T9Js7sKxLr4FUNeI7FtqiFNsPTVIPIG
         gge5wZTdj6H1fQVu9YW+Xp1mxHH8UZbawDXglyadRh61fwP3vvsqOmQHq2ShgfWI76hw
         Xb0Q==
X-Gm-Message-State: AOAM530X4j0eKigsq8NWZzmgvEa6Kh0ZmjHTiJ03PmpXb5y6/3NkhJ59
        umCYnSK0ZjWkEUwboy89DsFVFP/tKN53qZhvJWk=
X-Google-Smtp-Source: ABdhPJwTj281L/NJtVaGKGwRcXw+D3VXbtWrJ9dUcKDHjsmr2o0IbtVrxIzMKad1M+jcGHmxFMTSLwremfW2BjtevX0=
X-Received: by 2002:a67:2287:: with SMTP id i129mr90630vsi.15.1608225021351;
 Thu, 17 Dec 2020 09:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <CAGngYiWbQ2STTgh2OwJTqQ-niBDbbn+OdMkk7PMzYnrZWzSy9Q@mail.gmail.com> <X9uL13GA1uDbLJiG@workstation.tuxnet>
In-Reply-To: <X9uL13GA1uDbLJiG@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 17 Dec 2020 12:10:10 -0500
Message-ID: <CAGngYiW7vcJjz36xsBYx5n7=j1_5sE5a1AGpqC3Jj+tw0+FAXQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 17, 2020 at 11:48 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> I can initialize the values to 0 of course and check the file for other
> places with missing initializations.
>
> Or would it be better to check the return codes of regmap_read/write in
> such cases? I'm not sure.

I think that checking the regmap_read/write return values is overkill
in this driver. These functions can't realistically fail, except if the i2c
bus is bad, i.e. h/w failure or intermittency. And that's an externality
which I believe we can ignore.

Maybe Thierry or Uwe have further insights here.
