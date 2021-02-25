Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0A3257A5
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Feb 2021 21:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhBYUaU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Feb 2021 15:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhBYU3Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Feb 2021 15:29:16 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A6C061756
        for <linux-pwm@vger.kernel.org>; Thu, 25 Feb 2021 12:28:36 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o1so6077137ila.11
        for <linux-pwm@vger.kernel.org>; Thu, 25 Feb 2021 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4eHLGp721chnJdPwO6uZcOzua6OKeicZtQo55lPVJ8=;
        b=UnFTFbTL3lkN9ox2PniBTZrWFsUhvVW6QbaDv3hKnZTI1eLXnJMdqyNlp3O7YcCPa3
         RIF+xJWU6C2jfrhG0p4cv1M0RQ7FcU7rUUJcWbskF1T5m9Ko88vgi2mYSrnt627k/n5+
         d4AydKV/FHSnMXpbaTPXmA8Rj95YwxnHXJr+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4eHLGp721chnJdPwO6uZcOzua6OKeicZtQo55lPVJ8=;
        b=LBmgxXXrPtEi7J2SP6aX0bLEKFKIUIF16vlgwLU6ypEUKOcmrf3J06pFCbpN4NnDxk
         BmIBdD+aPKhUXtdiHfwA6kRGdJzzgoN2MZXBFhXdD9mili/ocrT9QKwowpUVysThYlpN
         YPhe3Z98RHS2WMEBdWF8VhexfJeyfCYvMO2Twad9kUY3vrrXhni0PhHwlaomIU+SVORw
         agOhtMSPvtbeb70obXSTn1JEManehasAJSCXbsGzErf/liZHY+QDsr4YtzgfNVKzruJy
         gyz8fEQjmWH/4dRmg/huEEzUNGaoIVPcu3a9tzxGCnMYK+HvFYgK4Wg0sPB8HGNHWsUY
         6yyw==
X-Gm-Message-State: AOAM531ypZ1ELF49uqYI3IdhD7obcscAYwe1YNjMZQAy0evk2h0cyaup
        zZ9SewDppQLC78xlMb1Dab1+NygynjWRcw==
X-Google-Smtp-Source: ABdhPJwKaEsGJpiAsI6lpqIbWQ+M/Z2MvpBY4cYKPTa/tnZqceuL8ZC+VPa0IX+P8IITEzchWHV3Pg==
X-Received: by 2002:a05:6e02:ca1:: with SMTP id 1mr3886379ilg.242.1614284915535;
        Thu, 25 Feb 2021 12:28:35 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id r9sm3537092ill.72.2021.02.25.12.28.35
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 12:28:35 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id f20so7295471ioo.10
        for <linux-pwm@vger.kernel.org>; Thu, 25 Feb 2021 12:28:35 -0800 (PST)
X-Received: by 2002:a6b:7619:: with SMTP id g25mr4350943iom.177.1614284914825;
 Thu, 25 Feb 2021 12:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20210225193426.3679817-1-thierry.reding@gmail.com>
In-Reply-To: <20210225193426.3679817-1-thierry.reding@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Feb 2021 12:28:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=witngtUa0Rx_C3semguau62obR3UQSTbQpUyp9YCUbNbA@mail.gmail.com>
Message-ID: <CAHk-=witngtUa0Rx_C3semguau62obR3UQSTbQpUyp9YCUbNbA@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Changes for v5.12-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Feb 25, 2021 at 11:34 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> As I was generating the pull request I noticed that I forgot to fast-
> forward this to v5.11-rc1 after the last merge window.

Honestly, there is very little reason to ever do the fast-forward if
the new development doesn't depend on new features, and I have
absolutely no issues pulling something like this that is simply just a
continuation of a previous development tree.

So you did the right thing in not re-basing, this looks fine to me.

Obviously, every once in a while a development tree would want to
update to a newer base, just because of various infrastructure changes
that could otherwise cause semantic conflicts etc if you end up basing
stuff on something _truly_ ancient.  But a release or two? No problem
at all.

Thanks,

               Linus
