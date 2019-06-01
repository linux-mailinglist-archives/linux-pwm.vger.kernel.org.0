Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6731BC2
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Jun 2019 15:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfFANDV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Jun 2019 09:03:21 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43705 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFANDU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Jun 2019 09:03:20 -0400
Received: by mail-ot1-f52.google.com with SMTP id i8so11922836oth.10;
        Sat, 01 Jun 2019 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0RT0bSFsstj788K6nAv5udFE+lgAJWct48DSKlasro=;
        b=PvsMTCfZZv2kYtmqyC+2t6ZuwaogZZ6iBuijIjh6BQFa+OBX44VkmtSbPb19rw7d4w
         yhxUlEOWxtAde/T/5iyWCT7VmMvA66Y6ervk1TZieoww8oVY6XwZUP/V/l2qIFCy+jqP
         8tVqCJYYKXZUrapR6ZQnl/uSrjzlhqDm/kEheq2BXba+JdtovMJvs6dUnQfzDeaoA1kw
         iLM85hh6FNvdb7iiQTCC2TIUq+AW6g75njjlnO1AApCKeLwTLFYdWoJhs7zihkdmZt0j
         SCY3MGSiLNPtmSkl263ZkhR2kAUrv805pe1CXDchiPZCMDjzbOmgplqbjaS/0QTabVqF
         +J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0RT0bSFsstj788K6nAv5udFE+lgAJWct48DSKlasro=;
        b=cknAjSx7QpUCS8f1ikQdMxBYo4oJOS662C2xsSD9w1h45BGO4p3oL7KltOpLZQdWRO
         4G3PRvspLeI2MvEmmsZa5NFhG5QmCPXJzum8tZjcsJeCduMAQiBbK1DCSzynC6MS7X0Q
         XxSPar5qsbLt9Nk4BHkF6ZAxAxHFJKzwrpF1FArRMSPLjo2Y0fr9buY3epuS2mZK0Yoa
         ca0RiEiSGjWFw8IlQ015b1fWoe+VsfWB0QUBYNpiWeJgt56PUosavc29nVZdgky/Cv2k
         VvWBOMex2f1t7Fa3oug9EZWmtHwVnGGMWCdhr13rXSBoRDpNmWmw5hhOGsP3oJ/2fjAa
         rvEA==
X-Gm-Message-State: APjAAAUSfDTZBn4RTn2TFF2/DaRV5S4Q7/h9gJqa8fsfXqetl5tnBZ17
        zHdIfd9Mh9jMujoIIKnBKxGlqNOlVqOCbb/85cw=
X-Google-Smtp-Source: APXvYqzLz/5A8GYcpQqqegkE3RMuS37XlWhCDzGUSDoA+PD4nPAEP3TWoiPuccwfudkUl8kBmvjHBGGyG71QdLgk8lA=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr5577799otk.232.1559394199943;
 Sat, 01 Jun 2019 06:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190601035709.85379-1-yuehaibing@huawei.com>
In-Reply-To: <20190601035709.85379-1-yuehaibing@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 1 Jun 2019 09:03:09 -0400
Message-ID: <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
To:     YueHaibing <yuehaibing@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi YueHaibing,

On Fri, May 31, 2019 at 11:49 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
>         mutex_lock(&pca->lock);
> -       pwm = &pca->chip.pwms[offset];
>         mutex_unlock(&pca->lock);

Thanks for noticing this issue. However it should be fixed differently.

This was introduced by Uwe's clean-up patch:
commit e926b12c611c2095c79 ("pwm: Clear chip_data in pwm_put()")

But Uwe did not realize that in this case, the pwm chip_data is used as a
synchronization mechanism between pwm and gpio. Moving the chip_data
clear out of the mutex breaks this mechanism.

I think the following would restore the mechanism:

>         mutex_lock(&pca->lock);
>        pwm = &pca->chip.pwms[offset];
> +     pwm_set_chip_data(pwm, NULL);
>         mutex_unlock(&pca->lock);

This would of course clear the pwm chip_data twice, once in the driver and
once in the core, but that's not a problem.

I'd like to hear Mika Westerberg's opinion, because he introduced this
synchronization mechanism back in 2016.

[Adding Mika]

Sven
