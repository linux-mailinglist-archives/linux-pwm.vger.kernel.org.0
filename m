Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4182E19860A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 23:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgC3VGl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 17:06:41 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:47076 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgC3VGl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 17:06:41 -0400
Received: by mail-il1-f193.google.com with SMTP id i75so10037685ild.13;
        Mon, 30 Mar 2020 14:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iABZKege7HQoVsTkUe4qgetZccJxeCXO7Xustigvp68=;
        b=nCkJceQYz63KMbp3As7XA/tB0F6HvC/2jrCVBKk1rnMzofyKp8XoOCATHV4Jnmi9+I
         tCMtPzA0HSJRPqHFgg8JlWUg1ZzZ94Wokr91YhNuHNiy+ym+9mIf3uvtBoNqrDly0Efa
         gcEvnecXGen2B+/9fdF/Y5UWNfjQ1rah7eC8DlbHRCJXArWOppEiLkvVsHoVpOPFPG65
         hNgbOj85wGsd9kBCFI0fr0/eXjpO/J1Ic+juYjl/rPhEhx9Bu+TjXCmylEo9FONEkNGG
         NUIxyBLLjAqwBqUoU8dBXr+VOFUeke/14z8hqGot3MQBtxHwmumSaHHXeoS9xQohGKnt
         lixw==
X-Gm-Message-State: ANhLgQ1zChRFEy3fmJ+S5pP8lo/knjKNv8x3GEROEv4sLrq1gG2oEkH7
        9jc8CDOg8q8eVthvt5Nb8w==
X-Google-Smtp-Source: ADFU+vs8rOfTPzeHqxue1CIuQVubIJ6JXVW/4a/numdBTmarNRQ+n//nuGNMsVS7Iv2pbFNYaL9Qeg==
X-Received: by 2002:a92:3d84:: with SMTP id k4mr13569581ilf.47.1585602399401;
        Mon, 30 Mar 2020 14:06:39 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z2sm5200482ilp.21.2020.03.30.14.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:06:38 -0700 (PDT)
Received: (nullmailer pid 9284 invoked by uid 1000);
        Mon, 30 Mar 2020 21:06:37 -0000
Date:   Mon, 30 Mar 2020 15:06:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Peled <bpeled@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/12] docs: dt: fix references to
 ap806-system-controller.txt
Message-ID: <20200330210637.GA9233@bogus>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf60ef88712e4f46f4e4bf40b2c646451d921827.1584450500.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Mar 2020 14:10:44 +0100, Mauro Carvalho Chehab wrote:
> ap806-system-controller.txt was renamed to ap80x-system-controller.txt.
> 
> Update its references accordingly.
> 
> Fixes: 2537831bbc19 ("dt-bindings: ap80x: replace AP806 with AP80x")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt        | 2 +-
>  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
