Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C81A36D4
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgDIPUO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 11:20:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46297 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDIPUO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 11:20:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id dk4so87090edb.13;
        Thu, 09 Apr 2020 08:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T/yNw7Oi6CyzIIjkIvIk0WZLkoS1PM8XtkC6qecQpw=;
        b=Rd4Hq+2tWp1D5xZlbEF7k3mWfg93I28KWIiMG+/MUKvJmmk/NfAGJWWn3ZWb88g44i
         bGFkQm2qHfI/JXf9YCc6/YvGav8daVwEX7Cy9YzjIYhBmlYAS601AAxqIxQpOQEo0FXl
         qyiP3oYGdcDKCpFCySfAV5G1TDIrXUfFr40T7QpzVe7wr9fRIju5b4hwOhUjtTE7sMK2
         4Y8niK/VW4cKFmYhxIgyshYeip8UUA96BKFZ6Fw/F+aQx+V2nw2TGTkkzwcBMENVTz3Q
         ZOIu54YI7HzwqiD0/DNasFo5ThK2AcnGKS72f2MXFc7oezs1aIBx4ku9X9m0PxhCVfLi
         79ew==
X-Gm-Message-State: AGi0PuZnVAXHS5KcBywAUYAwetUIqDX5oHNXnfAoVZPtX1pnh/yH9jJp
        ZN4BhGgppaNJz3ZH4Z6pwo5zsY5+jfs=
X-Google-Smtp-Source: APiQypLzhOk9igLGVjMXkxH/DSVCCMzI03tU371UYoJDa/NnEpxvHALpHL3oty0t0v+vVGWWjK8C0w==
X-Received: by 2002:aa7:c0d4:: with SMTP id j20mr516713edp.288.1586445611793;
        Thu, 09 Apr 2020 08:20:11 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id y23sm328621eju.85.2020.04.09.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:20:11 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id g3so12405660wrx.2;
        Thu, 09 Apr 2020 08:20:10 -0700 (PDT)
X-Received: by 2002:a5d:4011:: with SMTP id n17mr12170370wrp.104.1586445610677;
 Thu, 09 Apr 2020 08:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200317155906.31288-1-dev@pascalroeleven.nl> <20200317155906.31288-3-dev@pascalroeleven.nl>
In-Reply-To: <20200317155906.31288-3-dev@pascalroeleven.nl>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 9 Apr 2020 23:19:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v67LajWuoYChYhKtnf6fhd+uafyL-14_B0LHSS63NZbVJQ@mail.gmail.com>
Message-ID: <CAGb2v67LajWuoYChYhKtnf6fhd+uafyL-14_B0LHSS63NZbVJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] pwm: sun4i: Disable pwm before turning off clock gate
To:     Pascal Roeleven <dev@pascalroeleven.nl>
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
> The clock gate must stay on when disabling to ensure proper turning off.
> After one period it will still be disabled anyway.
>
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
