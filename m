Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671FE19E74D
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2020 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgDDTVb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Apr 2020 15:21:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35165 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgDDTVb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Apr 2020 15:21:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id t25so9413010oij.2;
        Sat, 04 Apr 2020 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0CB3EQF9UD+0fLIe/MYfF3PosbEA1dLe15Mmt1FMSw=;
        b=lm9kPC0cG5nIrHMBUSj2bELw+jg37M9VQ174fAaALZ8u56W4/703ed3hB4cgKP9oss
         O7SMhDZHzxCEpESc2yzNJ1sG/HBQ72apJ90uinc5e8i6zpL24KmuVP7TAfjZAx5YG6lt
         7M5WFFtri9SRV9zNFtLiCpaRGTfFNZRB/QaZgxWp0JBjYiWh/xYErWsZOEvrduStrIcn
         6keLykIK4wX0D9ldsobGQrauIA1QhD4bK8SRRBapTy5IGM/UMFtaxpD5IevP7jJa/YNW
         hj4h/eZbb7BsvXwtMRmjEXyfIJHKOv47Ehf/g+Gbd0Nvn/lZeJ1D3TH13PhIJgDlId5D
         2JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0CB3EQF9UD+0fLIe/MYfF3PosbEA1dLe15Mmt1FMSw=;
        b=QIOLnTmWdrVjBDVnnBt3vox5TfAOVOY+Yv+hDmLfG1VwxqvCOTfaec/qpBJLXvHhmr
         eXnVi5HnRJx9tv3Y9IM6QQNCGDbnqgI4e48752ntimnKjmnRA6+Unap7tGnBLXTG4W1I
         cXw7yaaJo9/lfJ4BznajjKUooDw+nFSkvVGt/0JF4dqK1ZMFefrjyDwLmGO1pBCkW+aY
         qfUKN3MeWvrymB2JCuoWSrEFT5tmrK39MWwNxkNfOHsNwtn2NPoPgLTL+mmsB1Am3S1O
         RsmrLhQStpCIGhLR5S3DvBX3+lTLZ68aopZzniy26D9Eeg1KblJ/jE1xYTA2JZvd/oQ0
         TQQQ==
X-Gm-Message-State: AGi0PuZrEobGrJVZRW6CYMzdB3md6ZpeAlFwYvpPAyhIpn45M90YjWVi
        lCHFOi+MZmQxy8bu1wFzcgEn9aePPRLZDv1Smzrr0A==
X-Google-Smtp-Source: APiQypL6O/df8+1cvS2PqUA2r/EvUBw1NrY1x43zaqhXB0hKOeWy/oNmo5Qd3jfEDW1V7qMMB3liwgNpxbk8v6Vn+AQ=
X-Received: by 2002:aca:b803:: with SMTP id i3mr7421515oif.92.1586028090586;
 Sat, 04 Apr 2020 12:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200403235324.27437-1-TheSven73@gmail.com> <20200404175836.GB55833@workstation.tuxnet>
In-Reply-To: <20200404175836.GB55833@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 4 Apr 2020 15:21:19 -0400
Message-ID: <CAGngYiX75gxrK+rKQcTVG6byAB+o5enC++J_0tHe6-6pRPMczQ@mail.gmail.com>
Subject: Re: [PATCH v1] pwm: pca9685: re-enable active pwm channels on pwm
 period change
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Apr 4, 2020 at 1:58 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> According to the PCA9685 datasheet revision 4, page 15, the RESTART bit
> is not only cleared by writing a 1 to it, but also by other actions like
> a write to any of the PWM registers.
>
> This seems to be the reason why I could not reproduce the reported
> problem.

Thanks Clemens for checking this. If .config will always write at least one
of the pwm registers (which seems to be the case), then all pwm channels
should stay on after a period change. And we (fortunately) won't need this
patch.
