Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6C927D1C6
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgI2OsF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 10:48:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45090 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2OsF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Sep 2020 10:48:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id z26so5706626oih.12;
        Tue, 29 Sep 2020 07:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Ib58i3Mc+qXCwlRZiyxQ8Wo1PM76xeIoDQNLOw2eDU=;
        b=s7Dzq3zah4/WE26QcG9feY7TxLATS6pskf4J5RIuv9wUEbHAFBxeqN66v1lZRxuDd5
         9/2rxh45nQrIHlefi/9PtZa2s58kymGX1q7SQ0M3VylY9GA2ocSVF3WveCbfHQSarApY
         UWFk2WWlo7kTeXESTFLlu0pAIdLaF5IC5MF6lc2yRiOYk5G2pEiFn2iYN/qb7kDeNwLr
         /Tg36yU2a0VL28UDQPbevAXJhfAg01CZgBjaveQ9Ck9aeBCYhq5RWMtA9M+KndT83dZX
         6zzZM9IdFQaUAHucBwwMRYPIPxMzbr7qj8P2iOGrYvxzcQpA/Dn8HxzFGb8qE4DE8EqX
         IXPg==
X-Gm-Message-State: AOAM533IHfRpgV7+hvok+yU8uFMARpKp1fTTHQmCReZKA18s37pwlC52
        Ee5f9TsVk+RGOcV7/As0mw==
X-Google-Smtp-Source: ABdhPJymV/FSHw0GdQywCDGO1aFF+Ijgni8vx/KH8HAnpEuWTTKdp/wVaqgKa7dz8ax8yF9EWFNMpQ==
X-Received: by 2002:aca:d07:: with SMTP id 7mr2951234oin.52.1601390884238;
        Tue, 29 Sep 2020 07:48:04 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm1029421oie.13.2020.09.29.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:48:03 -0700 (PDT)
Received: (nullmailer pid 567015 invoked by uid 1000);
        Tue, 29 Sep 2020 14:48:02 -0000
Date:   Tue, 29 Sep 2020 09:48:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20200929144802.GA566563@bogus>
References: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
 <20200929031544.1000204-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929031544.1000204-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 28 Sep 2020 20:15:41 -0700, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v3:
> - Rewritten as YAML
> - Adopt multicolor model
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 852, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 131, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 144, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:18: Documentation/devicetree/bindings/leds/leds-qcom-lpg.example.dts] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/leds/leds-qcom-lpg.example.dts'
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml:  while scanning a block scalar
  in "<unicode string>", line 131, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 144, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1372990

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

