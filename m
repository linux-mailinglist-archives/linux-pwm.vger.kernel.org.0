Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64B1822B9
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 20:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgCKTql (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 15:46:41 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38375 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbgCKTql (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 15:46:41 -0400
Received: by mail-qv1-f66.google.com with SMTP id p60so1468636qva.5;
        Wed, 11 Mar 2020 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DPlRt57hVmPu1xJsK9kfSRvEfdW8VLmNXskBXRBeKv0=;
        b=CVNn/vtxvSgWrVSqwZ0p2Vg6weNO0ZOQkm8ut5/0+5m9ZrBsyZKFYHhAk7LBg4lXIk
         e8ZiKkO5bYB+88luevOWS21eDrrPeQAdum/OBmXJcZRNNtMDCIhpIDlrtgzGpprPH9Jo
         UsLob5J+WImw9gxBI5NW/JlaqTNp/w7HkPt+hThc7odaKGCifU7oq6qEQrHYe4smBrnc
         4lwuIFAQtN6d+CiNpvoa0kBsuaRRMTYRKclU2jTpxUb3+zRdl6Hd2KWHeQi1EqDlPNWl
         dFyjG/00PizA4gnvlWfxF0KXTKGwIy5984/it4LX/7KeKMHuBV2LoKgBXf7xaTC32ak1
         ZG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DPlRt57hVmPu1xJsK9kfSRvEfdW8VLmNXskBXRBeKv0=;
        b=I+/OFYIgboA5x90zb3cN11QaO1xgMtydd55B5igsp0cPOlvl2C0Svduok7TT1ke9S1
         +nOpjFyptLVNgFmIUI77j74kwRN93NIggjzSynWvWKfq7RnkdpDn5pXbQcs+0f/FD8Y9
         AyKQ7B0MUzEZrWGRod/3dsYZECvk/TWyNT0/+fsO1y8lLb8Httif01IXCMXZx796qU7R
         AomtYEPfkQ8/C94lH7BC0KwuWPM9tS8dB/tdQmBYs+5RlFKlQXlhz9laDoW1aIC82TvH
         flnCD/1I4xeUKNH9k/Z7AY8/SBZl98RqepXLnDEeHpowbr7PlrXpW67xl65qD4MsMj04
         RfMw==
X-Gm-Message-State: ANhLgQ1Pe3OvoHL0yc7E/rBgOXPAIlAfRArbhFzY9Ax1Xsw608fUCKIR
        F6NBn4rCn12EY0XOvCP3W6SCEkWheLZs1PxD/Jg=
X-Google-Smtp-Source: ADFU+vsJkWgOZSHBFP/v0wrF1n5wfotuivrdqay2ldDyQjXR6r0bNGoQsFqKC6j6Lp3XgYNpGpoB4bcQBXH79wR3cz8=
X-Received: by 2002:ad4:510f:: with SMTP id g15mr4335813qvp.105.1583956000418;
 Wed, 11 Mar 2020 12:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <1583941429-10921-1-git-send-email-gupt21@gmail.com> <20200311164449.flzzwxqqhcxisil3@pengutronix.de>
In-Reply-To: <20200311164449.flzzwxqqhcxisil3@pengutronix.de>
From:   rishi gupta <gupt21@gmail.com>
Date:   Thu, 12 Mar 2020 01:16:28 +0530
Message-ID: <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused
 to prevent build issues
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, s.trumtrar@pengutronix.de,
        linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

These 2 links contains more details:
https://lore.kernel.org/patchwork/patch/732981
https://lkml.org/lkml/2019/1/17/437

On Wed, Mar 11, 2020 at 10:14 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Wed, Mar 11, 2020 at 09:13:49PM +0530, Rishi Gupta wrote:
> > The __maybe_unused attribute is preferred over CONFIG_PM
> > to prevent build time issues. This commit replaces CONFIG_PM
> > with this attribute.
>
> I wasn't aware of build time issues and thought this was just about
> #ifdef being ugly.
>
> Anyhow, the change is fine,
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
