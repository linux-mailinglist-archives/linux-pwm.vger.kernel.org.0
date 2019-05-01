Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AA510DA2
	for <lists+linux-pwm@lfdr.de>; Wed,  1 May 2019 22:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEAUBH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 May 2019 16:01:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34441 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfEAUBH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 May 2019 16:01:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id n15so83211ota.1;
        Wed, 01 May 2019 13:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HxbNQi9DeZ2IJLgdIUVTw8HAwd2FcPK6Vz/jlq7BRoc=;
        b=qWYrQxsnaeocSKQFVcRphBkA+vycl3wfxbMvcbh6w51iBZqqrzHsnlfDrmXw4HeUlP
         gdNWtOFltDo27ymGE0JLiSKjMG2Lim8qYypZUbCbjAeh9MblDhIyb/rTep0D7526Tys/
         iICmLFmBS9dJYCHZ3L9lB0DMHCwfQsrBafFdqrNzMG/WZS1zCaN7vdFp8yHq/lcw6vh4
         2afxJkJeVtUQ+fV3UVd1UpEt6lRzSOzfU6u+kwAq5rqKhDIn4qWpNp8dnNcehjmY06bg
         9+OpjtWXx6gI9R90su2E3HYTJMy/RDVteapxetfzpYYFFmmVGCCUa2sE4SkBnsFaVlDf
         4uAg==
X-Gm-Message-State: APjAAAUdrXzVuW576feo8uN1wa3bf0EnyYgEvoTMZmY+G7tNDfRgXIIn
        6HQD9Ai7oga6j+FXKgGdfg==
X-Google-Smtp-Source: APXvYqzcF2UnIXneOHc3vVzJEv6m01JtjNnKY2BTBLXgguBiPwEBqQ+LDGuHzLgGqqLZG3bvV/MztA==
X-Received: by 2002:a9d:2066:: with SMTP id n93mr14060248ota.193.1556740866212;
        Wed, 01 May 2019 13:01:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r4sm16901646oia.2.2019.05.01.13.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:01:04 -0700 (PDT)
Date:   Wed, 1 May 2019 15:01:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, devicetree@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: Update bindings for the Meson
 G12A Family
Message-ID: <20190501200104.GA29281@bogus>
References: <20190423133646.5705-1-narmstrong@baylibre.com>
 <20190423133646.5705-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423133646.5705-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 23 Apr 2019 15:36:44 +0200, Neil Armstrong wrote:
> Update the doc to explicitly support Meson G12A Family.
> The 2 first (A & B) AO PWM uses different clock source than the last 2
> (C & D) AO PWM modules, thus we need to differentiate them.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-meson.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
