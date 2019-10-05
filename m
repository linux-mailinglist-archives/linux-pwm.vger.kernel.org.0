Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F49CCCD9
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2019 23:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfJEV0t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Sat, 5 Oct 2019 17:26:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47003 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEV0s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Oct 2019 17:26:48 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so20795185ioo.13
        for <linux-pwm@vger.kernel.org>; Sat, 05 Oct 2019 14:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q+CVv9o5PkxG1PPsGrI10rFFWUP+E0oC29I6RGXPEIU=;
        b=rXbX3S1JueI7w34zoCFUoP21rCWSjfm+tq4voSwRG1ln0p46olr5HR+FnXhy4NMkmh
         Qt+tFFZIra6qJXHZi+S/1aF3GNTkzYblLAh3Clx5DZN5CCOK4P+Op9XACvf+H2OzNcNp
         WjjT10lPe/4zyxK309J9e4ldzoV5rP9kObo3iFFt+JmXCEt7aw4C5cIX43fvtoF5wP6A
         RYCto9T8gz33WTnTfMd4kUWqlTOKEi19SIAIMftMuu1FlRd6+BHK4HsVNiRcoUgcJfEb
         ExDhVtT79kHrGn38icLQsP4WiG6WWENDFp0VONkrBOxJbCBuA0RBr+K86AfOtPGLpJwx
         q7MQ==
X-Gm-Message-State: APjAAAUNZKnCwtsjvCVucOu6+NseBTjT7lbEfxrEnZ1epF/rY7jp0oFd
        EyuqQhUFmG8XdKtxp579FYN4XDF1cedYtKBZ71+MQ3QC
X-Google-Smtp-Source: APXvYqwqaAUBJuc66cGtdhj2Wnsq3e0fnVxJUHDmBCyjR0ISUUORUCsnhfUEoGWsXOyO4d9epmvglFTfQtXln7AWpkY=
X-Received: by 2002:a92:388c:: with SMTP id g12mr23359212ilf.9.1570310806634;
 Sat, 05 Oct 2019 14:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANBLGcyvpxWDxjpBrKDTySgUXGYFdn66O6_2jv-W5+RYd=n3pg@mail.gmail.com>
 <d959e6d0-c727-5c1d-b554-9306eba7f9ca@kleine-koenig.org>
In-Reply-To: <d959e6d0-c727-5c1d-b554-9306eba7f9ca@kleine-koenig.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Sat, 5 Oct 2019 23:26:35 +0200
Message-ID: <CANBLGcx9jf+QDzrwgRdpn3L9__zPgEuCE=i3Qx1PEvs5JuEDgA@mail.gmail.com>
Subject: Re: pwm: Let pwm_get_state() return the last implemented state (01ccf903edd65f6421612321648fa5a7f4b7cb10)
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Sat, 5 Oct 2019 at 21:53, Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
> On 10/5/19 9:37 PM, Emil Renner Berthing wrote:
> > My Chromebook Plus (rk3399-gru-kevin) doesn't display anything when
> > running 5.4-rc1 unless I revert this patch. It controls the backlight
> > through the cros-ec-pwm, so I'm guessing cros_ec_pwm_get_state doesn't
> > behave in way compatible with the backlight :/
>
> Can you interact with the machine even without backlight? If so adding
> some printk to the cros-ec-pwm driver would be great.
>
> I suggest to print period, duty_cycle and enabled at the start of
> cros_ec_pwm_apply() and at the end of cros_ec_pwm_get_state().
>
> If you'd then report your results with and without
> 01ccf903edd65f6421612321648fa5a7f4b7cb10 reverted to the pwm-list
> (linux-pwm@vger.kernel.org) in Cc: that would be great.

Sure. It seems cros_ec_pwm_get_state sets duty_cycle = 0. Here are the
relevant differences between a kernel with and without the revert:
http://ix.io/1XIU/diff

If you want to reproduce the debug patch is here:
http://ix.io/1XIW/diff

/Emil
