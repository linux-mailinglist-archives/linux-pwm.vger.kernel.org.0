Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B1F104303
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Nov 2019 19:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfKTSJ6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Nov 2019 13:09:58 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40127 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTSJ6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Nov 2019 13:09:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id d22so611161oic.7;
        Wed, 20 Nov 2019 10:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzyZQ4fEqLiui26PMcdzE5fiKafIuHsPZ+HchTRfUPQ=;
        b=AmRkJnDyfodCdHEBNQxSQnCQVWcy4LzEpZOEBxA7fkkyOeU2vyYRXa8nyJGV4ycrCu
         673spSZntW7NAOFczUnkLtvLW3z18GLGfZqzITUBcLnjP0HwEOmhBEVbNL7ADURF9ZMX
         X3GV0gBKOvHdcP9fKTTZ1BPTHndscfQzgQ1N7/m3tooKhKraBbfp6aKEA7CTcSVbXmSi
         XLTHH6JVQjSYIt6ntPv4vw7t+LK7K9iTGxTVv8Hmix7T5NwwJjNdoKTKzZVGEWTWLX2s
         rmltvDCSdcmYlZJR7Of5ix/QsoxirM1zSRjzAs5mHtF6Psx9sozPEszTQlMFBm3Q5pXX
         dZvw==
X-Gm-Message-State: APjAAAV+KA3cCRjNZMpP7eO2f6oDUJbYM2KT5NHzBnENzNUt/w1UyEtv
        nNhk7CpJz6u7XVQEpN3vkQ==
X-Google-Smtp-Source: APXvYqzaDfbYrfeEjWY541EKHP6pgAPEWL5ptEcD1hGCgK+Un3JISnVZs/7iXribLlYOAxWgCIgp5w==
X-Received: by 2002:aca:cfd8:: with SMTP id f207mr3990174oig.145.1574273397185;
        Wed, 20 Nov 2019 10:09:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a10sm8305379otf.72.2019.11.20.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:09:56 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:09:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     fabrice.gasnier@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: Convert stm32 low power timers
 bindings to json-schema
Message-ID: <20191120180955.GA22823@bogus>
References: <20191118094842.20171-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118094842.20171-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 18 Nov 2019 10:48:42 +0100, Benjamin Gaignard wrote:
> Convert the STM32 low power timers binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in version 2:
> - improve counter function description
> - set reg maximum to 2 instead of 3
> 
>  .../bindings/counter/stm32-lptimer-cnt.txt         |  29 -----
>  .../bindings/iio/timer/stm32-lptimer-trigger.txt   |  23 ----
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  | 120 +++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-lptimer.txt      |  48 ---------
>  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  30 ------
>  5 files changed, 120 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
> 

Applied, thanks.

Rob
