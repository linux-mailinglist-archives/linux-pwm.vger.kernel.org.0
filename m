Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D62409F56
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Sep 2021 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbhIMVsB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Sep 2021 17:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbhIMVsA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Sep 2021 17:48:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250CC061574;
        Mon, 13 Sep 2021 14:46:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so16847320wrn.5;
        Mon, 13 Sep 2021 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UJFYmKaiKX+U8tYrocTLv8vJXCqW7HNRqpVncpU4+kU=;
        b=S435dpVYV6d55P+/I4KaADbaRIgRZL3acsevwYj95w38epYPwVQfZ3gLs6VFEcjvnU
         j0KBQ5ADTSjwk4dnXYaP8zGhMsaqYhPBBL72+C0AM6rDBhYaCSgIO6H+sEZdD5EzH7Yo
         pe6D4w2ponO1G0JHoLrh0AziFs3T/iPTAe29/UAH85EQDQRGomit8YMVLg+wVGyrkKUq
         g/dABHosoB88JwaYOdIsfOaJNTODqZaY5pGw02wg9gLsP1T3SJ1hu/yaPNlFDQIutksK
         ahihRlA1vkoUh5Heq2HjWe/kHLzglSrcZJXDcO4rbctmoWpeE3V4KSt4JIDTGE+6A/T/
         zHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UJFYmKaiKX+U8tYrocTLv8vJXCqW7HNRqpVncpU4+kU=;
        b=z20cOCB6y9DJxHNgfdrOO78lQC/xXMHWzH739YJTcfbLJod550+Y6NYDPQgewvJ30P
         qsZZsaYZyPighuSiuQI6yojtnXc2BCPZAnSJjtoWSy5nZvtjxNXu6pyX/J14IyK9ADh2
         PFCXDCQTPs0A1/8x5XfUKOSM6b5WUsyZG7DhfoSnEbx928Iy/FORbT5KP2+BUkhMyfgB
         X95nKYKVm7pROysh47qZ61DlT5Hg4hRfk1zQh8Pw/i1Skm8TCCUXvaVzbUj5cJuRKrJF
         OqUqULnTGP0KQr6iiRyPRurfrneQTb2GP6W+D9hTsl0Uk0THZ2xPWpC2uNWTj65dcP9b
         C8cw==
X-Gm-Message-State: AOAM5303GEo575tasufvBd0C7cS+3L8sPv7qPPYdtz26hZaFmI38Hq/U
        U7s+uFXGjgeM+rs7HtR1UBU=
X-Google-Smtp-Source: ABdhPJwfmmsiFWkjS/kmTkCxiwx8H9Pq/x/hF3EI6Kp+IBk76nLgKeMnvYnM5Ur7ldhAtsSoP3jdwA==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr14852824wru.350.1631569602436;
        Mon, 13 Sep 2021 14:46:42 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id x13sm8446167wrg.62.2021.09.13.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 14:46:41 -0700 (PDT)
Message-ID: <c2d54eb9c0061a779678e311ee6761fa6f117856.camel@gmail.com>
Subject: Re: [PATCH 7/7] pwm: ep93xx: Prepare clock before using it
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Date:   Mon, 13 Sep 2021 23:46:41 +0200
In-Reply-To: <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
         <20210613233041.128961-8-alexander.sverdlin@gmail.com>
         <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, 2021-06-14 at 09:22 +0200, Uwe Kleine-König wrote:
> On Mon, Jun 14, 2021 at 01:30:41AM +0200, Alexander Sverdlin wrote:
> > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > to Common Clock Framework.
> > 
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> 
> Maybe it would make sense to move the prepare into the probe function?!
> Anyhow, for now preparing the driver for the common-clk switch is the
> focus and for that the conversion is correct, so:
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

would you take this patch only, please?
It didn't work out to sell the whole series as one piece and
most of them were taken individually...

-- 
Alexander Sverdlin.


