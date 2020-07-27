Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE022E6A0
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgG0HdK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0HdK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:33:10 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB74C0619D2;
        Mon, 27 Jul 2020 00:33:10 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c2so5517874edx.8;
        Mon, 27 Jul 2020 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95o2SL2yS+OJ42B7vx7vpE8aa2uvVeEjtGJk2w185hM=;
        b=reT1y3UM0/eHiiOk8AjpyJEGO5IZw7wNJAYn9rDmVsKIMJPwGvujG9/JMiuIrosiZv
         WyGZ4ADs5yhYnEBDvFEk+7Ve2c3jVQ4nuUKG1PsFfuKwcoBw7jS89lEQRLKj+wkF+f6K
         YMo1wEaBR6SMBzWfnfSoOHmwSovsord7w9qtESgRyXIQoD/GJgOJor0fh+C+ncsdtd7f
         ZAfZDHto385Fr1/D4UlfZj5S9Zgq9jg8ur/NISYj3PQizB4ILuL2NzIc743IXwduuUyj
         LjGWhBnJ4OwUsAUhNyh3H5ZRgOc5YObSNQkjkzWfkzZwVdsKarf6IVET9AviCzhzBnf9
         /hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95o2SL2yS+OJ42B7vx7vpE8aa2uvVeEjtGJk2w185hM=;
        b=meqPkt9zEPYGrlxkx4svzRJZJd+zs3p1Rvnveri3rjDgPFRcrO1rUfYr5bOMqWlSfz
         LwjvKtD09d3G1iOVCueSvB3uSoXeMtq6j9v9meBo074PY46SPXEU8n9j3VC3VpZXZdxr
         TpbKEkJCMqwI9CWm4nSJWU7xD+zRr9Fg7Nvd7sC0y6pUp8R/3eCht+xfhP4fR0sXkId9
         +3d5Fu6OsbVFyB2iBtIaSkn1kW+blejiZJgzl6XNGACMxH0sdDoMCBHsSsHqlp8mOTNs
         37OroRoh9N69Cr/ttgC/sK0soILi3Zx+W0jdz9h8hdQdzditVqCNE0gN79oSInm8hp8y
         HKXQ==
X-Gm-Message-State: AOAM530YrittIk+mswE/gUoZTFhzQmRRAiuJp8FuXTVRim0edjV/DCM7
        k4946zEAfIZ/kAwVLDXgGTIO2YBjjyVqI4NMej7qAoZN
X-Google-Smtp-Source: ABdhPJyY4JZi0jBFS9XuIKOB3L/gBL5RfEZTypoj8YM0d14GZMRw8scieVd3NJU8rhon6bN52FrwzCZzwxF6z8BX+HY=
X-Received: by 2002:a05:6402:d06:: with SMTP id eb6mr19513491edb.211.1595835188988;
 Mon, 27 Jul 2020 00:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com> <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
 <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gmail.com> <CADQ2G_HYTE6cd=PM2JzCTadkPe2DDb8dxObPdPJtz1626ktE9Q@mail.gmail.com>
In-Reply-To: <CADQ2G_HYTE6cd=PM2JzCTadkPe2DDb8dxObPdPJtz1626ktE9Q@mail.gmail.com>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 27 Jul 2020 09:32:31 +0200
Message-ID: <CADQ2G_HF+eBgNJVgFS4OP2FBOHvvPE6rkPz3vjSG7PZ3qm3igw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Could you please send the messages also to everyone else ?

Next time of course.
