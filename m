Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89ACC19DA07
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbgDCPYN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 11:24:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42023 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403989AbgDCPYN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 11:24:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id z5so7596327oth.9;
        Fri, 03 Apr 2020 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zrV6aMoQP0OG/C0OJzaZF+AdqvWLaIPf/wEdTNZQRU=;
        b=Summv8/x73AjqUwMRxLplgt7uLutXeavNAmS1VxZDngJe6tfl9XJjRH2FT5lQv0R8d
         q7NtekvE7pxAiPcdeg9Z7HOe9HngcaREXDHF122svG77okJ6fhmIVX0y2XWj1Q+Fms5E
         lZP2AsCpfqZPb0lKcMBDKKHIpO6BU023IdFJrIEqUEPLPqUcU6eEdd18YkGqcNhP7GhB
         5QRrpvSO5J/+iGNYZ2dF30TG3fqxbqopERyFuFWWG1+YBXOGZov6wCpWksxU5gOzSNAo
         vca03xelo0gPV6h8heH4SkC27P50kXhiYKVrGbWTU0BXZLXqEJL0XGHXz23D7U9maa0+
         f2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zrV6aMoQP0OG/C0OJzaZF+AdqvWLaIPf/wEdTNZQRU=;
        b=JcdkfPtmMcaEQIFX5n0X+p7+aRen3P2eomj4VcNfVhX+LsIUgwu+gObervpZDsAMmM
         Zf6MiAAz5bkZuMLKd+HUDsavsf8+CMNwKim0yg0JP5asitD8yW5WNtdpwz9QCUOCZ1s+
         ThvvjrwS/Dccu1Xf3MyK3LzYx8elfYu66x31Zp26YOYhbmakB4r2tdth/mMXz2o++FRT
         NSx2IPwaqq0+4KjQ0sysw330BGdN1tTpN/1DDPQPK2NrTrgl9fuDwy4h27Vu+TxC40eV
         0kv/ARrlsDe+CsxIwQlC7HKSpZNhMKFoIZTQU1kiNntlpPZsf6tEWgEWmmvowFIC3bgO
         s0Fw==
X-Gm-Message-State: AGi0PuZR+Lb+XANkefe0/yd7lnzMOlYLikqPBT6N/mvFuirZU9qfESj1
        IwIc/Lfvi2WIDcYyoOQAsFdeb4oza36lPE88xm8=
X-Google-Smtp-Source: APiQypJdYCI5EAAkXsrAsNjxBuDc16qdH+HQrgehiNnmqRR0fcrX95nUqIvu3W2IMeNvDZ9Q/Mjv+FMPCY7pUANhFaw=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr6986713otk.232.1585927452403;
 Fri, 03 Apr 2020 08:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
In-Reply-To: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 3 Apr 2020 11:24:01 -0400
Message-ID: <CAGngYiXy5-REGTnUgrFDHdbskX7FkkO2UBkGok8NOSc14RQf5Q@mail.gmail.com>
Subject: Re: [PATCH v2 REBASED] pwm: pca9685: fix pwm/gpio inter-operation
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 1, 2020 at 1:01 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> From: Sven Van Asbroeck <TheSven73@gmail.com>
>
> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> [cg: Tested on an i.MX6Q board with two NXP PCA9685 chips]

Thank you Clemens for testing and rebasing this patch, much appreciated !

The synchronization method introduced here still looks correct to me. So:

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com> # cg's rebase
