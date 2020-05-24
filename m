Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA91DFC1A
	for <lists+linux-pwm@lfdr.de>; Sun, 24 May 2020 02:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbgEXAYf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 May 2020 20:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388106AbgEXAYf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 May 2020 20:24:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF3C061A0E;
        Sat, 23 May 2020 17:24:35 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v17so11325749ote.0;
        Sat, 23 May 2020 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kekfxXMdb8bE1LuIOxDVSOfLlMhP6qizU1VyVltzXYA=;
        b=U7nTUaiPPwYH1gzE5lpymmoyUozSFhrWpXJ8DpzQGZEVc47eXF8mrAEn463M87cpEw
         uWcDH2Ul+tyGdHxYW0M7BLGn8MeR4E7d1dtsw7o22u6QqG4nX3llZNB7Fqgn813tIX3e
         zC4ZOzPdwQy+af2hnh57kYtlt/xC/5e1/vnw61TQoFfUX4mYIaRstpAP/hDkUdSqVUlX
         Df9IuSkYo8QFxoC8OSMFEiaA+CbXPS2he98UpKdlY9obZNKVe0NK/VTPkLPN3AObCfN8
         pAMbs20yCP/zK1P1APR0rvcWj+NmQryGQ02odPRdRNFq5XmZHdGvfMZaEEM+1SQx16vG
         BZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kekfxXMdb8bE1LuIOxDVSOfLlMhP6qizU1VyVltzXYA=;
        b=RQJfVcQB7se66SYezS7t8LKIZtqBcicZ+ohSn9z+AczUGUmxnT8eWVKCjhSFd6iWeN
         qjti275X0dqnJp9TpDwlqTeGVrA28pPFx9UiUHPZ8bWaCrV7FfKwrN6BOEGJzEI+ZV0Z
         wUY4/tNbMCQ2GdUGWXPFrF8IvT4bP7vwtimv3txj4mmsfPsRWgeV4bkpwJ0lbqW5S3GV
         LGxUk4X+KoSfc2fEMqVuFLscByV9nabMfBRX2w15u6iUBWG67VKRkPh93lE7s3jccZTR
         C0Algt3exMZIgWpTm4UHkRtSeSWH6CfD8ZbtQrSFCIHyrupn20sq5TCuIuG7qceW4Avq
         9XvQ==
X-Gm-Message-State: AOAM532feW06N4aJoIsqixu4+dp6G6BmpGs+bHyigBgF4zAny7/2YPR2
        O7GeBo3ZgTDpSp3SmAFnxh+QM42VL4yIgu1xZNkazPMBZXc=
X-Google-Smtp-Source: ABdhPJwuA88Tv+hCcPRHPd8gqY+yFPdjYiEomp6Y8HjMkRwiqh4Bb8lzKej1fozAKRmWp2BxiP0iwJcGKvAPxBjn2LQ=
X-Received: by 2002:a9d:3675:: with SMTP id w108mr16677732otb.116.1590279874351;
 Sat, 23 May 2020 17:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
 <20190606151111.14237-1-TheSven73@gmail.com> <20200523201730.o7y7pent4hjtgia3@pengutronix.de>
In-Reply-To: <20200523201730.o7y7pent4hjtgia3@pengutronix.de>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 23 May 2020 20:24:23 -0400
Message-ID: <CAGngYiWCT=_H+PwXRTgMWRpwRWMrgvA3vD1is2r704oZn14LiA@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Sat, May 23, 2020 at 4:17 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Is this patch still relevant?

A slightly different version of this patch has already landed in
mainline. Clemens Gruber had
relevant hardware available, and was able to test it out.

See Linus's tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/pwm/pwm-pca9685.c?h=3Dv5.7-rc6&id=3D9cc5f232a4b6a0ef6e9b57876d61b88f=
61bdd7c2

Have a great week-end,
Sven
