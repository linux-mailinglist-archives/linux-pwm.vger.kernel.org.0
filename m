Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8558E19DA19
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404096AbgDCPav (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 11:30:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36917 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgDCPav (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 11:30:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id u20so6433338oic.4;
        Fri, 03 Apr 2020 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uo/s3g2M9m8e4JRBF9iXkTq11nxfJs4YNqOuK0g635s=;
        b=HwzTvOxKFbg1Nzxrq8vUyWts33+FbCcwLokJcdRvNaXKqErhG2dXIAtKvLxgG/aHez
         +hv8xB/7//Dbm/Zhmw5+OnUMdnntE0JiRYjRTMXIpD/2mwRPUXI6Zs0JXbt1nq+b7rk7
         ym+veq5DBylx1+j2ThMJRjNLl/Rm3cFjtKPHmJGNO9uiPa1EwEHpnk4q+gUXJzeFWkFT
         R1C+bhvARxZ/UIcsvJIq5KbYt8Zuytu+xxGxWiiCifJRM321Vb5EbvUGLH1rEZ1H5O8q
         HJ3E9lHC8Qzx/GgGDDYd+U3eODbMU01qEDPAEuMRX1mOq8bh+kqTnRFUURO2Nb03Jqra
         DUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uo/s3g2M9m8e4JRBF9iXkTq11nxfJs4YNqOuK0g635s=;
        b=sHlXZ+iYzT40lgkvwc96I7B0jSnAQcjN74PVVP3B0rfICJF0jaPY96Opedm3e68d88
         3OizYSngcrKcQGnEk3VlByqzxN+4SExNcStHnJzyhtikgt1LHpFOK8mBdUiYmFp+D/Dq
         W8YQYgb5JeviflxEUzIJ8MNtGt58z8RBe6orNLJkPyRP+0ScHKMBHNJu8x04JJZALt4G
         OwdZn8zgBcvz/wAGRjop4hPnjEjq04DWiN7tZ3GWCKB5DzYcZSMt0pMLSOaTxe0cZYyP
         8Qrwd52Nvz2Y/mrvB4g54jFnPcNyAEYeaoS/cctzYXDv7DE4LlkThxNZvjmTqaTfD5h+
         49Ug==
X-Gm-Message-State: AGi0PuZzG3GsIz3TaFSm9LcxuwfLk6Si1up+LYbZtqKjlou1XVAExt0Z
        /WvBeXRLRHmyGxUuhdGRKqpAUOkKJ4NTqrV0oFo=
X-Google-Smtp-Source: APiQypJ7cD+pwX0/P2wdrT1+MMVyWXdLAxFwYHg2POSGg74nohO0TPq4/RAfSM2lHxhXIIs7mpaPEkf0RJ05d0WUul4=
X-Received: by 2002:aca:b803:: with SMTP id i3mr3363192oif.92.1585927850037;
 Fri, 03 Apr 2020 08:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
In-Reply-To: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 3 Apr 2020 11:30:39 -0400
Message-ID: <CAGngYiXR7pPJ4kTXtzmL1T_yrbr_gs0RVFo5yufmJGc08xgeMg@mail.gmail.com>
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

PS perhaps you could also include a link to the mailing list
discussion which prompted the revival of this patch?

Link: https://lore.kernel.org/lkml/20200330160238.GD2817345@ulmo/
