Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926392DD825
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 19:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLQSRy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Dec 2020 13:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgLQSRy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Dec 2020 13:17:54 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823EC0617A7;
        Thu, 17 Dec 2020 10:17:13 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id x26so15469055vsq.1;
        Thu, 17 Dec 2020 10:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lreBswTZmdhoZl34f64PwY2OY4iG8wqpqVXlkTTIcI=;
        b=rZe+7uERrHIn4VnPVW2S+lLemUthb82HuWIAGFCURjE56CvrIoDRR0TRcSDW6ifkoi
         fKsSMku96DLzT5ueCWWig3knzGdU/ji7/B1zGf9+SPV3egr6muV4cVldlY2ZqZlANEcO
         JuqTEJ47u6iS43EvCMEU7MWjCZXvrK5z/l288c0nsMqSLRO6E4fTSaVLfoszhFd59+PB
         4I9TkCJLkeGIuOwELAOs/SFsI1bEsQL+PgIgKsvyx+fi2AMJGHPrbsb1RSCT7N7Fd3Dn
         853O2deotXdkKyRB0re+v4GkxdzwHjTBs+gLgRQ+VY4ytJGtoUIhCL/P3nt2OdibuFaa
         LNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lreBswTZmdhoZl34f64PwY2OY4iG8wqpqVXlkTTIcI=;
        b=CFo9xtIGrUf4Z0n4D2EEOlWUp3TYlhpnn/bSJyIdDiu+f00wwxwUcTstDk6HsVFTGi
         WSJl3jaZ1fxNxSAiiU66hDjh5aObt+OhSEsGSuX1rQROY2/gFOSuohl51PwjpzxRJPMT
         2scIgCMd2K2E18n6H9T0pfuw98mjSQZ0GJ8tZEpeGSQJyxXt6qN2zXBjYY9zsK5YtZXJ
         2GvoJzbKmtK3XzWFx5D6Wo0dJeVbYkROBOTlhD306LjKoIiN8rTQ3aTG2g8PmQXRa4bQ
         AZqK4EfFE43yimWoINrEbxjr3KcpvbHYqtyslpMfxFtdy/fwcHnJ/LSalK/d9HeZ4CtO
         bm3A==
X-Gm-Message-State: AOAM532g9x4617WM1UwUT+ug9EHfHphY8+Xk5ZwwxHtfzIKvJBvhGXVW
        M8zrwWIXP/PvQ5frwOx6FBtWMe5ANmXA8k0ixA0=
X-Google-Smtp-Source: ABdhPJw7EIyOtieZWR2hD6FN+hSFLDqvrIoCFsPd3aAPheyWfISJRwhsjF1wGu3+Cj5QmlbfvY1LcmBbo8WlivSLq2g=
X-Received: by 2002:a67:d319:: with SMTP id a25mr614829vsj.57.1608229032778;
 Thu, 17 Dec 2020 10:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <20201215212228.185517-7-clemens.gruber@pqgruber.com> <CAGngYiWHrq0f=bQSRpkHtU6Uo4UJ8XoNTxdT6o8njE3cH3H2Mw@mail.gmail.com>
 <X9ueWvQs7PhvoQT7@workstation.tuxnet>
In-Reply-To: <X9ueWvQs7PhvoQT7@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 17 Dec 2020 13:17:01 -0500
Message-ID: <CAGngYiWSEEKZFpDwOpZd0L48PFY=yjV6vAbOChAnjHcHM6F9uw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] pwm: pca9685: Restrict period change for prescaler users
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

On Thu, Dec 17, 2020 at 1:07 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> As always, great review! Thank you!
>

My pleasure, it's great to help out.

And thanks, you're the one doing all the hard work :)
