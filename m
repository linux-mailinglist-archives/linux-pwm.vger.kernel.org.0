Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516281A36D6
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDIPU2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 11:20:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39059 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDIPU1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 11:20:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so164071edf.6;
        Thu, 09 Apr 2020 08:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T94ek2P1vYjI/992XAZLBRMZNsTOICz9I5cPd7mOb1Y=;
        b=mzrZjMkRW/o5NoomEAwXZwJ5KxzaRRqj60MUgloLMKFMNpFnqGcS5YIml+AT8NlH6V
         X0Od1hFTxiSQk0D4dKCTOPZ380wsiSJGXVbmpq3CEB14be6Az0VGbmzVMSYl6iZ6jo+Y
         sBhHPHKVX09zrO/d9Tpusy19Tq+BKwsFAXsYPhVr+wQQFdqkhhb91akUf1PhVukEOUYK
         m9CpXyANp1/sOKefcCRhy7tK+VVadWp+LWW1TP9iqpuxOazDdkGCDvIB/Q0Vdo2vHowY
         +T6/WnxQxJrp1mgJPaLSrRdWmGmuy19DBybQ/GjcCxBMuv4KqCLHKfUX8RF4t6Kaj0oy
         OfqQ==
X-Gm-Message-State: AGi0PuYQo7H6WLYmeYT7Sya1CINWPlJCGebWdjk/j4e8PoRxXcTi3Qi1
        uhSc9Nl547xmdaffW8clp/rUfAbpkxw=
X-Google-Smtp-Source: APiQypK8drmw0Q19H5k5r1DrvIBs1ZGn+eskzRrhqGIrb9EuNXVSNRon4wLxA6w0TLjvGRXZzYzCYw==
X-Received: by 2002:a05:6402:3118:: with SMTP id dc24mr553164edb.40.1586445624055;
        Thu, 09 Apr 2020 08:20:24 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id e10sm152239eds.2.2020.04.09.08.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:20:23 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id 65so12401477wrl.1;
        Thu, 09 Apr 2020 08:20:23 -0700 (PDT)
X-Received: by 2002:a5d:670f:: with SMTP id o15mr14577113wru.120.1586445622945;
 Thu, 09 Apr 2020 08:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200317155906.31288-1-dev@pascalroeleven.nl> <20200317155906.31288-4-dev@pascalroeleven.nl>
In-Reply-To: <20200317155906.31288-4-dev@pascalroeleven.nl>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 9 Apr 2020 23:20:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v65X3QoopHn11K48UbRMfTH2b9SseOR8U4jWWprGTTQB2A@mail.gmail.com>
Message-ID: <CAGb2v65X3QoopHn11K48UbRMfTH2b9SseOR8U4jWWprGTTQB2A@mail.gmail.com>
Subject: Re: [linux-sunxi] [RFC PATCH 3/4] pwm: sun4i: Move delay to function
To:     dev@pascalroeleven.nl
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 12:00 AM Pascal Roeleven <dev@pascalroeleven.nl> wrote:
>
> Move the delay to a function so we can reuse it.
>
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
