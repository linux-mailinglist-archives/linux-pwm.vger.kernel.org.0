Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD335D2AA
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbhDLVqw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 17:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhDLVqv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 17:46:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29134C061574;
        Mon, 12 Apr 2021 14:46:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd23so14036495ejb.12;
        Mon, 12 Apr 2021 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uFUrnfIf09ezybuVkP04vDSdaVZKjH/YcufmPLg/EJA=;
        b=SR9/ZPn34QjAzkHsEkByTJNEzre4oYG+GlELLhGkzdPICK2PzHnAXXdR2kuXrH+JBV
         3CKshQfZrIH1zhl0sLSqUr+P3VV0MLnge6GRs/X7RQZosh7DpOd69z7rfaU4e7xlM7a4
         nK+TlRUWEScPLSU81NiDnDPKd5sFB84OxNqnYwdL0QFMQXrvFEE3/sP1z8mu5mc86h+l
         QmvlwgwJlwiBHWyBHIl1JnnBfffDXI4QEZDTs1fM8XNFbI0e7kSUlf8sWhXASFkqHPxl
         sWCLRhK0IdebQcZRq78nfb4HRO6gO9aIk3+MdL2X/qbRVOMtraGSvKcqjc8E0f4rOYdg
         dSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFUrnfIf09ezybuVkP04vDSdaVZKjH/YcufmPLg/EJA=;
        b=Rg/ifEv5zp6xbGEm3lmCaBXbUAOkQOfDL9SCqnpQWvWYV4/trMMkRKp36am7oMCkDX
         nZ+1j2VSa4Y6NiU8MKXGw0W1La9F0tyxxKlNfYZHovwft4oi7BancxaYlKkpPZ99j/XV
         A2mChI9kGDYqyPs2xQNYO6L53B+oS7Vd9eivKKgT2cgET9fhhu5y5tlu3HRzRkVyCfiK
         ISx7qEzGFiDD88Xohdw0GGhxdD8cJ1lAfrQXum8uD5syErEwKiKshbgnaILNTrAi9JbL
         aTeeTv2YaY07Fjf8Av9LyMz8E+EmolmCHInxSkNqgaHqQspaKXQEo61tx5sZ37WssDxa
         XSyA==
X-Gm-Message-State: AOAM532vArwjLEB/LA8LSyF67P7bTCtk3B8msvRUJadT+NFE/ClEa4Uk
        cxadQGdip6H1bSdmHATQPUc=
X-Google-Smtp-Source: ABdhPJzbzVMu26M4OrHzDAxRyzivV5rBNL9tM9AJWb1TsGiwOAomqyu6SFHVzQYgqpT8dKZrtMd0/Q==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr29208531ejs.522.1618263987967;
        Mon, 12 Apr 2021 14:46:27 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ke14sm1698718ejc.1.2021.04.12.14.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 14:46:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lee.jones@linaro.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, heiko@sntech.de
References: <20210411131007.21757-1-jbx6244@gmail.com>
 <20210412205753.GA158321@robh.at.kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <5705f804-5db0-1d14-f853-02be72fe4d2c@gmail.com>
Date:   Mon, 12 Apr 2021 23:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210412205753.GA158321@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/12/21 10:57 PM, Rob Herring wrote:
> On Sun, 11 Apr 2021 15:10:02 +0200, Johan Jonker wrote:
>> Current dts files with 'pwm' nodes are manually verified.
>> In order to automate this process pwm-rockchip.txt
>> has to be converted to yaml.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>> Changed V2:
>>   changed schema for clocks and clock-names
>> ---
>>  .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
>>  .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 91 ++++++++++++++++++++++
>>  2 files changed, 91 insertions(+), 27 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
Hi

This tags version 2 with a little mistake instead of version 3?
Is that correct?

Johan
