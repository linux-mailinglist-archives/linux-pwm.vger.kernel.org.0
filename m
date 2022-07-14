Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4378574F3B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jul 2022 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238858AbiGNNd5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jul 2022 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiGNNd5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Jul 2022 09:33:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D2F13D0F
        for <linux-pwm@vger.kernel.org>; Thu, 14 Jul 2022 06:33:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so2591107wrr.6
        for <linux-pwm@vger.kernel.org>; Thu, 14 Jul 2022 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D18Kutt6mbbmqTCIRA19IyVjLN8EyvtScWXKLi6ZISg=;
        b=hqorxo4MDyobyVxLT9TXEwV/tp8Wwh9AU9FtNtoj6bsbfpsueGJ32tLAENvPergAuZ
         N8hKZK2znbOL+DZorXWEx/aWQL3NGrUpA+CRoPW1EEsVhXfQcioUcwaDKyq5NmR1hzhB
         ahJWfDJTHHAdJ2FKQqIXWi3kAXOF/t8CrmaHAUI5zaZJ5sBJVdoGDFCC6quMpPDWE+bj
         xSjy0KpFsOiN2ChyM5A8HsPmI7/RWXqYNryg9PYlXiS83Wkag2joMZD7x3MzZPUn8+sJ
         Vbe/1pyzbx8prBaYEvnq7pXSqMotz9RZRZ5Yag/aCL+FO+uVYQCzTNczSrBCfgE3u81w
         leVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D18Kutt6mbbmqTCIRA19IyVjLN8EyvtScWXKLi6ZISg=;
        b=zIpgyX4UxFtnCkIs/htoG8rfPYTk8R6blzVQ71M5oVfKmdlfQiP8auDeTINBEZxX/2
         ISNaFZf4flYUqKN0yFmZzS4tjOfuKhf8+WAkq6ofQwO17QOXoLRiXg/nChtOKFgWORxg
         rea1l5i7RGc6H1h/9Dh6Wx11BaDzBLw1qL9Vm8Zl1vufc0DsQCudzrCCpLdb13LMmaNI
         xVYdI8Ol4vpXnJ/C7YIINAulHAwp0gQuidBfreobt75/oeCwBp/CMx6WRuLX92hE1cRE
         G+aJ29OiE+0WfNw7EeBxY0EBfsZm9Vz0wDPnvDJHXtrDGrL6wPYf0g89JRfQB69xPK7R
         Js7A==
X-Gm-Message-State: AJIora8T01Iq2fnxsRPrarXuX7oO1R9J4R0J80iaKNxq9AytZPqzBFp2
        57vtam00hGv46qW0tZfNzjOUhA==
X-Google-Smtp-Source: AGRyM1ufEuVtQlYn/mNtEPlqQl4kxuAgaboI90kRIy8ihaY3AZuKeuA0EJs0TwRKO9ooHu0YyAWq8w==
X-Received: by 2002:a5d:56d1:0:b0:21d:78ad:c8bf with SMTP id m17-20020a5d56d1000000b0021d78adc8bfmr8385497wrw.175.1657805632856;
        Thu, 14 Jul 2022 06:33:52 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e39-20020a5d5967000000b0021badf3cb26sm1803458wri.63.2022.07.14.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:33:52 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:33:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 8/8] dt-bindings: regulator: pwm: Update Lee Jones' email
 address
Message-ID: <YtAbPnNzoBqgPDDi@google.com>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-9-lee@kernel.org>
 <YtAUN7yFFWTU5cpZ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtAUN7yFFWTU5cpZ@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 14 Jul 2022, Mark Brown wrote:

> On Thu, Jul 14, 2022 at 12:25:33PM +0100, Lee Jones wrote:
> > Going forward, I'll be using my kernel.org for upstream work.
> 
> > ---
> >  Documentation/devicetree/bindings/regulator/pwm-regulator.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Do you also want to update the comment and MODULE_AUTHOR in the driver
> source as well?

No mate, ta.  They should all stay as-is.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
