Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C8FCBE1
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Nov 2019 18:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNRbd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Nov 2019 12:31:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36929 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNRbc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Nov 2019 12:31:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id y194so6031925oie.4;
        Thu, 14 Nov 2019 09:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3G1UrTKYq6h7EeCf3xtk9ByNRfqNtMiSs5YT8e3r4Hw=;
        b=eS5yEwbnuVBbDQBYjzVfMgJAK3auLxE/WxBGyCZbdA5LrVZl36NA+i4ZuddlAidTTy
         LoG5nRmyEtMDELckh++qOgYYkZZhJ2XOp1FojntwMSMLLSziOmtFmzKQm/6lI9SdUwLD
         L0VH+WaVgHPzYmY2BJ/dEbYXXiMr66m9fGPBOg13Jq5rKlDVFc5XpqLzl+4A4g10Dhc4
         e3xpIVWg9mnW3vhM+Bid1ULCAqpYQHaxVSbomtAC3cxWQP2I1YIZ73tZFI2j8pvmzunG
         fNDDxsMElqGxvPw77oXQnAqY3eD0lQRYXKe1ZGI/FMcTozoWmqxrYVID8/PJ1HNwJq10
         vUQA==
X-Gm-Message-State: APjAAAWshox70p1VUW4hGicSuI+i7WADQ+67/eRWZPe71VpuXjdRxDv7
        +BdJyQGwx/xcPo2JG2E4GQ==
X-Google-Smtp-Source: APXvYqwyclOEvGyBTY6vREWnjvU+4uvkYPxZcorcMlSKeYf3ZPoZJUiEVybWjLsGdKUcmAP2Hril7Q==
X-Received: by 2002:aca:5e04:: with SMTP id s4mr4533315oib.159.1573752690884;
        Thu, 14 Nov 2019 09:31:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o4sm2019336ota.57.2019.11.14.09.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 09:31:30 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:31:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: Convert stm32 timers bindings to
 json-schema
Message-ID: <20191114173129.GA25237@bogus>
References: <20191114101823.23144-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114101823.23144-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 14 Nov 2019 11:18:23 +0100, Benjamin Gaignard wrote:
> Convert the STM32 timers binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 3:
> - correctly use enum for dma-names and remove additionalItems: true
> - provide a range of values for reg property
> 
> version 2:
> - merge all (mfd, iio, pwm, counter) bindings in one file
> - fix typo and trailing spaces
> - rework dmas and dma-names properties to allow schemas like:
>   ch1 , ch2, ch4
>   ch2, up, com
> - use patternProperties to describe timer subnode
> - improve st,breakinput property definition to be able to check the values
>   inside de tuple
> 
>  .../bindings/counter/stm32-timer-cnt.txt           |  31 ----
>  .../bindings/iio/timer/stm32-timer-trigger.txt     |  25 ----
>  .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 159 +++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt       |  73 ----------
>  .../devicetree/bindings/pwm/pwm-stm32.txt          |  38 -----
>  5 files changed, 159 insertions(+), 167 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 

Applied, thanks.

Rob
