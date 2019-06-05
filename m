Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF335D88
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2019 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfFENKq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jun 2019 09:10:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34798 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfFENKp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jun 2019 09:10:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id u64so18136793oib.1;
        Wed, 05 Jun 2019 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3f5m422kvL0u9Kf0/muHVokQ+2t6+FHah80qokLVsnY=;
        b=FmqrRta1t/7cOyn9VqCJaDbHn4YVd2OftBV7eHNkachVXJw6FvemotYVv+s5Dc4hJg
         R3ZgCb1yppXHojtymcHyL8oe40aEpAgISlojLkFID2/zAjhC62uT9U6JIjO4JI+s+7ny
         5baTEgojrVTGD7WL2M6sNdGEvEkvmbOnY3/ZneKur+aLOsECBPdo48GXz/CjjCYI2zhZ
         1R1No348TAGsZqDF2C9hBKizUTZ3UQ7d3nlcP3VswO6O9bhFy7VjsxhRRh5+8JB5ujti
         77zBdYN+q6PnXV1cTF8zELdIw2v3+oXZgnOKhWVhmmHK5gqizRjrH5IXF7EQlA2KQH8f
         NHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3f5m422kvL0u9Kf0/muHVokQ+2t6+FHah80qokLVsnY=;
        b=RAc4uNG4CMXRRFzGQKwlZ3rZ4S/9KTlmiBkKtJO4MRVrZju8P+MJAqtUktcVmxj6ay
         5e8KW+RG6JR34Adss74sswHlFytnRJWksoBTLnk9+0eNxU13nT3VpAKmXJqqL9IgieUZ
         kogSy/RlsDFnhXP0kWnKjcCE5cmhGdWJ+pC/v0W1szsx6r26Qr8tKjEB1Dbrct/aHKzz
         KgGuvcgSlYkSAj6BA1KalV5nd7fMmkflKrTng08MVqz/A67FxX4h1VgcTC/rwWtFw7cI
         aynfJqCTrNI8SPLQbGfEZK0s9HGv40gGO6h/BJkMEOK+Rg7TQFyUVlE224TFAI+JbGGb
         1iog==
X-Gm-Message-State: APjAAAViLWrsFwJiOmDC8y2WZKzdPoX2nVkAcSSH2Z60gHgc+au6MVHh
        i7II6WC/cLEyN8BpfmnWXVZFuVtUgKGOfKOW9+8=
X-Google-Smtp-Source: APXvYqyVN+421plTp7nk+YEo+BpgA213pkYMjcMVIhLkgyKM1ssokXoH86WjU5Wk/iR4Z8YTfoyZRWk8woeCNiKZ9Q8=
X-Received: by 2002:aca:cf0f:: with SMTP id f15mr4331358oig.169.1559740244927;
 Wed, 05 Jun 2019 06:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190604181345.9107-1-TheSven73@gmail.com> <20190605125356.GI2781@lahna.fi.intel.com>
In-Reply-To: <20190605125356.GI2781@lahna.fi.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 5 Jun 2019 09:10:33 -0400
Message-ID: <CAGngYiVX=-UtMpvkYKrL+f5s_PZdLNx+VRA7tSCsN1UJWaSzLA@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: pca9685: fix pwm/gpio inter-operation
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jun 5, 2019 at 8:54 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you. The next step for this patch is to test it on actual hardware
(which I no longer have).

Is there anyone in the thread willing to volunteer?
