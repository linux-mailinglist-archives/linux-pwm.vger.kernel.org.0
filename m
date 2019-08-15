Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5258EBA7
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfHOMiU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 08:38:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37481 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfHOMiU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 08:38:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id bj8so1039177plb.4;
        Thu, 15 Aug 2019 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ee2WC7wFUitxl0VhlNk/I0IaNSildZhX3LeEHVWcaU=;
        b=bU7F69OaIb5ke+Qt0qr7HlZwNfbiYKkzBNNDd8WzOHgsvEfE1khSOgq2w7EpiRuWPh
         uTqfEiRYLy6fq3vEnJnH7/iPX37E1FVbVulx7Vv4U18g2VLI86sei7DpxGqKZDZ96V8+
         rSoDO6VJthK6lxxQXoyz0eywkCeUmf/HVebo2WM0qgyPW9iHxjb5jXIwCH/78l9samiB
         m2STME5iKjiocHcUzIBq5wqyuPgAlKn7Cq1b3FOToXEt7XIEjowRnd3jV3pH+WCgbrwb
         y/wg7L3zNnBb2BOCFeUQahe99n0O2JYWx17ui9xB37TfI3KFvJtxA92FplWroT1DsaAR
         LHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ee2WC7wFUitxl0VhlNk/I0IaNSildZhX3LeEHVWcaU=;
        b=ovbZ5cY9Trf6ZwcGv1tYn/TZUTd+r7paJG4+Q5oFgYBYbVsvoewwFhgpB4eNPFlTxI
         jC9jY0iNn7t7e74onD8L0NcWQQFnmHwPF10gIIoKS1ijpZ5vpjI31Gmhnd2616ZwhO/D
         +hSDlydnoBQceM8gm9y3+0Y2E5jAX37hF+uKWCIbvSo6sE1FbQUl8bfZPrYVlctdnM5J
         6MLCJeLG3TTRS9pD2Il8x3sXkQNsm3riUVG5lJ22bFoRs/eZyWWxa6w5G9SkR2/x8hbo
         a95v+VwN4FeDcteDIJSd5QzxGFd92DllBoHg06K3IL3xe/EPNKrCEQezfy+DA28eh8n3
         VwTg==
X-Gm-Message-State: APjAAAW4Q1sF4cJSddhaYGVhTutcImjlbyFSSC+7b+p3BbND4I/mSz3L
        Tk6BajHMEOfijOLvFgXpwkk=
X-Google-Smtp-Source: APXvYqwacwndMgsXukx1fTNdcEaTu+xtzJYP9eajJDSzmxObARVKtVJS5xCwgo93gUEa6Hu2wopekQ==
X-Received: by 2002:a17:902:e60c:: with SMTP id cm12mr2573361plb.304.1565872699079;
        Thu, 15 Aug 2019 05:38:19 -0700 (PDT)
Received: from icarus ([2001:268:c146:4483:71c4:4d14:b4c7:2693])
        by smtp.gmail.com with ESMTPSA id t4sm2836798pfd.109.2019.08.15.05.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 05:38:17 -0700 (PDT)
Date:   Thu, 15 Aug 2019 21:37:58 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 3/5] counter: new TI eQEP driver
Message-ID: <20190815123758.GA646493@icarus>
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-4-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807194023.15318-4-david@lechnology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 07, 2019 at 02:40:21PM -0500, David Lechner wrote:
> +static struct counter_synapse ti_eqep_position_synapses[] = {
> +	{
> +		.action		= TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> +		.actions_list	= ti_eqep_position_synapse_actions,
> +		.num_actions	= ARRAY_SIZE(ti_eqep_position_synapse_actions),
> +		.signal		= &ti_eqep_signals[TI_EQEP_SIGNAL_QEPA],
> +	},
> +	{
> +		.action		= TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> +		.actions_list	= ti_eqep_position_synapse_actions,
> +		.num_actions	= ARRAY_SIZE(ti_eqep_position_synapse_actions),
> +		.signal		= &ti_eqep_signals[TI_EQEP_SIGNAL_QEPB],
> +	},
> +};

Hi David,

Just a minor suggestion for your v3: you don't need to initialize
"action" here since it'll be automatically updated in the core
counter_action_show function to the value returned by your action_get
callback function. So you can safely delete those two ".action =" lines.

William Breathitt Gray
