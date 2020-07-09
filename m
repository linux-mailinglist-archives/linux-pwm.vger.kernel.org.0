Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB29321A5DD
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 19:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGIRan (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGIRan (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 13:30:43 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB18C08C5CE
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2020 10:30:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h13so2274810otr.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2020 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3m60qlJpb4zSVwjX3KfuFM5A8w6HuVKnF0CMOiaKyO0=;
        b=oh/vaVMffz6NBpk57JhA0bccxQ+CgY2N8B2O4IVgQU4KbWtY9xo9fUav21zjzPGRFu
         XzNKfFHDPNOfIkq/8qYU7rpnUPPTFWELncvRei93tj7/zkq1Y7dFa7rEUaMclB0JOBqV
         OUtatGCohXqF1J7LdbhoOA84aqKaifMwZaw74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3m60qlJpb4zSVwjX3KfuFM5A8w6HuVKnF0CMOiaKyO0=;
        b=gOSAT6R6ChisDlxXeGLAfEKSTL+yFtcM+paorKPmW3LWGmdWsN8CdDXT4qT5nE4EEO
         Xp+r9bV5VFj1UPY7hHgfnyklJ8CqIypyhnWUIqRkEGzwUjcM9GtOVv546sz0VBVRMDRV
         YVDVrDcZSphiNjnnJw9X4bZGspNC3zgGJ6BWpukdVU9my/t9G8bG96rwK8sHB9XT4wvO
         iaxLleOz+kLG56sZOIWZkocISXhoJu6kQWbp/6wxacV09dciXQhRMHE/N3SJc+euSMiS
         BRueNE244BAIQW1raEqKQAKHonEl4DXTvF342E0DMUQD3lmTcDr1zzVgHqJmtjgkc5/q
         exyQ==
X-Gm-Message-State: AOAM530MU5JqqvJqIXa7csORrOBD9XyZwKNDcBJCneaYJu1DCVIkxdxB
        698OzjHMh1SFFqQsiRLxtgcXRRjOdyHBplolyBzQHg==
X-Google-Smtp-Source: ABdhPJw7G6FF2diX1q8cHlRwPzJnbtDmb9sO/T7kW+epnUE2deow+2VW1fqrGUJP7FP/wVSXruBBnpkZ0T81v6/XMvw=
X-Received: by 2002:a9d:674a:: with SMTP id w10mr49598426otm.305.1594315842379;
 Thu, 09 Jul 2020 10:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200709144527.23528-1-uwe@kleine-koenig.org>
In-Reply-To: <20200709144527.23528-1-uwe@kleine-koenig.org>
From:   Paul Barker <pbarker@konsulko.com>
Date:   Thu, 9 Jul 2020 18:30:31 +0100
Message-ID: <CAM9ZRVt8V9mPwAtQ3pvPqGc-Zuxs-SkcoSNk49JipwvERByGdw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: default to #pwm-cells = <3> in the SoC
 dtsi files
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 9 Jul 2020 at 15:45, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org> =
wrote:
>
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> The imx-pwm driver supports 3 cells and this is the more flexible setting=
.
> So use it by default and overwrite it back to two for the files that
> reference the PWMs with just 2 cells to minimize changes.
>
> This allows to drop explicit setting to 3 cells for the boards that alrea=
dy
> depend on this.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> this picks up an old mail thread where Paul Barker started to work on
> this in March. He got some feedback but didn't come up with a new
> approach.
>
> Compared to his patch (Message-Id:
> 20200309145558.16098-1-pbarker@konsulko.com) I overwrite back to
> #pwm-cells =3D <2> in the board .dts files to minimize changes there.
>
> Best regards
> Uwe

Thanks for picking this up Uwe, I must admit it fell off my todo list
due to the coronavirus situation.

Is there a reason why imx23.dtsi, imx28.dtsi and imx51.dtsi have not
been changed?

--=20
Paul Barker
Konsulko Group
