Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079B340AB7D
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Sep 2021 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhINKQf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Sep 2021 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhINKQf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Sep 2021 06:16:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B85C061574;
        Tue, 14 Sep 2021 03:15:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s24so8777818wmh.4;
        Tue, 14 Sep 2021 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Nf/SOAvbwz2MygXok4/Z17dVM/UAKbfgG9bWv41pHME=;
        b=FlxD/nRhMOE4Q5Y7glvWLTVOuMWtLGBWL6qrtwOixRTjOKrhziCZJQyEA0SKdM5Hjl
         /Kr/4ygu5IpdyTvEVAlEEoKfT0gz5d3FEeezDR7AYS1ogtLNgSpLEGTEzRcio3yq+hcp
         Id8Bwc5LnPjYwJI6KxYMrKEJMyDfz7W9vy4SwfPvYxQLd5gcnqNHtdBDUkNVPIt4JFp2
         nSQEkoYhILg2ZFY7jWPw+ppBwWOp+lW6VfHKZCBxTQjANOmESftDap+oT0cTsRB8a04f
         NlvLfTzOjjwtB/b0s/mrKT43uAYPKI1m2KFN0DzKTpgbwCFOQiEHqKHNMD4RXnDl/vH/
         f4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Nf/SOAvbwz2MygXok4/Z17dVM/UAKbfgG9bWv41pHME=;
        b=WU7ktXO6BDR5jwWeND8YFIzcb+zPesF9QjprZQuiklBoXYdw9obNqA8YQauGAHo67P
         vZmy6wyUdB4aJz3Gop6HeiJrQ2D64XVEZkMJGdvY98GyWW8hqKKCBKzgy/olhYQs/Ub3
         yhCrhDhTowzxcqyToU+GirMm/4V4QZEBnzSLf4ENTwGgvJduQ4/iYn6xjlSue+DCQPVA
         kTuV+gRHwj56/Nm5gYkd9IfS2N4sNk/vgAULSl7d9kiHewVlv3p1mlHt6rEjgN40hrmI
         JX07fBskLztqsXUOCwCOJngfJWyRK2c+s+wzq0jMqYlsiVcJJBiFcstVZH50DbAE9LPU
         XZNA==
X-Gm-Message-State: AOAM5332ygzFKM+8Ifv8u3vs2YT0gAcaE1iresVROri2BsImnIkNQ1qa
        QFy7TRNrZuZjwzUBPuvTfeE=
X-Google-Smtp-Source: ABdhPJzuZr0B0EPomiy8tK5LoL4hiLNe8IGef5SfQ/IkxN0UfwcjP+VlZTPId+hGZkBk6caLIaeWjg==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr1299438wmh.46.1631614516919;
        Tue, 14 Sep 2021 03:15:16 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id 48sm10335007wrc.14.2021.09.14.03.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 03:15:16 -0700 (PDT)
Message-ID: <173088b768fbc1dbb49b6f53f7ac04a44f120f3a.camel@gmail.com>
Subject: Re: [PATCH 7/7] pwm: ep93xx: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>
Date:   Tue, 14 Sep 2021 12:15:14 +0200
In-Reply-To: <20210914075815.alqnyux5ficgvkme@pengutronix.de>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
         <20210613233041.128961-8-alexander.sverdlin@gmail.com>
         <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
         <c2d54eb9c0061a779678e311ee6761fa6f117856.camel@gmail.com>
         <20210914075815.alqnyux5ficgvkme@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Thank you, Uwe,

On Tue, 2021-09-14 at 09:58 +0200, Uwe Kleine-König wrote:
> > > On Mon, Jun 14, 2021 at 01:30:41AM +0200, Alexander Sverdlin wrote:
> > > > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > > > to Common Clock Framework.
> > > > 
> > > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > 
> > > Maybe it would make sense to move the prepare into the probe function?!
> > > Anyhow, for now preparing the driver for the common-clk switch is the
> > > focus and for that the conversion is correct, so:
> > > 
> > > Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > would you take this patch only, please?
> > It didn't work out to sell the whole series as one piece and
> > most of them were taken individually...
> 
> Hmm, this patch is marked as accepted in patchwork
> (http://patchwork.ozlabs.org/project/linux-pwm/patch/20210613233041.128961-8-alexander.sverdlin@gmail.com/).
> There is also a v2, that is also marked as accepted
> (http://patchwork.ozlabs.org/project/linux-pwm/patch/20210726140001.24820-8-nikita.shubin@maquefel.me/).
> 
> Not sure what want wrong here

Sorry for the noise!

-- 
Alexander Sverdlin.


