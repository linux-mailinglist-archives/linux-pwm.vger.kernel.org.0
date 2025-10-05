Return-Path: <linux-pwm+bounces-7392-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4367BB99DF
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Oct 2025 19:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58999188FCBA
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Oct 2025 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F032737FC;
	Sun,  5 Oct 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i1aNIVIT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012046.outbound.protection.outlook.com [52.103.23.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD56374EA;
	Sun,  5 Oct 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759684073; cv=fail; b=U93vmmoaOw8foLzlEG7Y6EAImcrxET0w2whfQOVXb9Alk0vEYTkVvTMdwsH8rLpjDkMZm4vKI5N5sBs0B0G4nO1OpvTu0hEJdR8TCz7Ch8guAStXY/N1Io29g0Jg2wFbzCelWEDJ7c1DNfjdWIjujZEKYBe8wo9VVW8loyP2Tg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759684073; c=relaxed/simple;
	bh=Kol2kWAdn2ZXgFcOXiy603z6dY9lkB2ziJY2b/X5PGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XupqHFWKmVtU2NYauL2BPm7I7kY2LRXd2U0STaolYFKYpXRv9ucZOagoKb2yNJltL7rrKpb50JwO2l+6CEX7nKN9Y0NSMRYZoh6+usDsUqaewhRM5Tr+v1nYbaUGo/D9IT+Lu+mns5S94Uo+0hqVs/aRfMmA7Llo1c/EN/KZYx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i1aNIVIT; arc=fail smtp.client-ip=52.103.23.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjtbcE9qDmP9z/Er6GxlgM3bDroIu5+ATkk7Fe+Vj9iN2K+S8rMwoRrIeZ9tBFjW8c/run1OyFiJLek+lPjj+elFO1NAhcvGh8WiV/SibFmxBmwiVKEY8VE4n/WbgY5ix7CWpU5vqCq5z3L6NSsfXVpEfqZHYRswewkocD03GKPFFeT1oOj0fd+YMjwZa3/0EKIaQazASOcQUSxeDd4xO/oMqof3JAy5XYPQcTDJlzN0AhPD4cQFpv8BgWWDi4cfjFseUtRdVlGMRsk7TIHQQjzfyAnhPZ0/6tsrxUBD9UFyThntlRoGMnJVdP9WPcNSU9xGN1uuUdpUe73a27BkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICEAXfUMzQKn9+GAL8QLmyqM3G1pLaJuP2ziU0KSaRs=;
 b=NgtK06FoXeum8PspdCosqVtf59A5qKaMKo7mm3nkOi4AYE+vTDq/g69n+zY5PqBHtHnb6uv28iyTnmUsjsyGkr5m+fJsuYcWjq48y80uF1jAAJlRkjqjeRKe1IXaJbiQz8Hu0IVVKMC9mbHUtuX348H9Mop9Eqpkd4ddj8Bp7XwktV8DEv9E/IJfOvtlG45yXE4MGerTjkph8Scq71surBeuc1w1TnSkqOha+Bd4zLbRLM2j84Vj7TKASz2G2EkIC5NJE5G3cj1XmdAjFq0f+E9VDu6+s6I18LNEtGzl4lmMHmC6xzSka1gES/mk1NyPrzCj9PaOhMKy8dYi1i7F9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICEAXfUMzQKn9+GAL8QLmyqM3G1pLaJuP2ziU0KSaRs=;
 b=i1aNIVITGyC5t6BajhThq1Uw1qi0kuvbR9qsrp1fVXAAqp7j9d7VUIjdu35Wdw0DIb1scdDryavlKlV9jBy003uaVj0IFIfinmmdnk1rOKwVaeKuNBBMdjzA5M2jYvC5pfbsxWoScSoA+oYo6aeBTdLLk+fwG+6/tdDBTetdom6XIgTSYZ3jAjAxylBIrb5gushxdvOkkrtDlne8EJiS7GmMNGTaxDDHv3s92gTFX6z/WQS5lUXvwfzfevBpXEGlND6LRRSs7qvq0xPsGppg49wHOMgDVMUYJgRmpY41H5zXlEfVN4HR4X4lvpBeAEubAVS3lCQtb2VZ5ur+hfAkuw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM4PR19MB6464.namprd19.prod.outlook.com (2603:10b6:8:b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Sun, 5 Oct
 2025 17:07:46 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%6]) with mapi id 15.20.9182.017; Sun, 5 Oct 2025
 17:07:46 +0000
Message-ID:
 <DS7PR19MB8883089D146F101AB2F7F8DB9DE2A@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Sun, 5 Oct 2025 21:07:39 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add
 compatible for ipq5018
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-3-300f237e0e68@outlook.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20251001-ipq-pwm-v16-3-300f237e0e68@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0015.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::20) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <7b2b88be-875f-4167-94c2-1d30484c18aa@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM4PR19MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: ef500a38-29be-4917-d21d-08de0431b456
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|6090799003|461199028|5072599009|15080799012|23021999003|8060799015|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk9kSzJ3RXM3RmtRbWVCYVNoQ1NYYnZoeEs5eFFZdWFhZGdQeHNybHZRNHZZ?=
 =?utf-8?B?OUNFZnJ6a1MrN0RzaWZYb20rS01qcVl1eTVmckNnaEZMSGd0YmRaYnlZY28v?=
 =?utf-8?B?TEF6aExXVzhpcTZYR1IwbmlqNTlURFdqUUR1TDBnWDY4dmZ6bXpudnVBckZJ?=
 =?utf-8?B?KzZtaWxTKzZpdVg4bXAySndKK2pMcjdheHlVbHhBK2xZZTM2cWFPQjFPUEVr?=
 =?utf-8?B?a0V0eHEzVmRqYy8wZTd0c1c5YnBxUEdONkFSOWNQbEZ4ZHlEdXBOVzVYVyt4?=
 =?utf-8?B?dGxnM29vRS9wajdtdktpMFBUQ01DalUzazhjN1lFMU1TdG5GNmJ3RDFOMXVS?=
 =?utf-8?B?am5BeXl4Vmd5R1VWSHp5SXgxa3RIVys0RVpTU2N6WGlQMExDdjdNUmJqWWEz?=
 =?utf-8?B?eVJyQmxvLzVYR3hrc1RXdHgyT2J5ekd2NU9OKzZyRSs0UFdOSGgyMUhYdlNP?=
 =?utf-8?B?QUplcjFHQk9NT2xNODd2VFVYV0NjbXVPalk1OUZudkU1TDdxVC9FSXNqWk9X?=
 =?utf-8?B?SUFRckNKTXFnL2ZBK3ZuZWlRWDErSFphdVJVVi9jTDFjRFBHa2kwZHcrV0pY?=
 =?utf-8?B?SlRWOGN6YUFVMnRvcnM0Y1VHZFFxK28vVVVSRmpFNnpPKzR1MXM1UzJjUTVo?=
 =?utf-8?B?VzFMbEpUOFhkYUxOUmlEYlFZcUVpMDZXUTFYSE1oZTFtbTlJaTNhcFVDaUln?=
 =?utf-8?B?SXhrOHRaTXk2L0dpZ0Y1OXY5WFljR2M4MnFVL3pqUUxyaU1TbmJnaTVscW5o?=
 =?utf-8?B?VzRuUTQwWVZNVXpFMzdsSjZXRnJhaUZQcGR5QXd1KytGL1FzMCtlVVhOcjZB?=
 =?utf-8?B?UEd0V1BnK1dWbXk2Qkw5YUlEV1VreGpPSUxiS3Y4L3JjV0lKKzl4azJXU1ox?=
 =?utf-8?B?andFV2JqdHFhOVNtSFNjQlN1cnVIWFgwNnpBU0g3WjRsWXUxcXdBa0kvSVFl?=
 =?utf-8?B?cko2QmYxS0pVUHdtR2NTdkVsVlVKcXhYV0FpUEY5b3p6YzNMT0ltbmFsazA0?=
 =?utf-8?B?WXY1elNxUXl6ZkcrMmk1Y3VvbVE1cWY3K3Z4YUQ5Zkl5NXp2bnhSaXlUU3d5?=
 =?utf-8?B?RW05bzJubWNRRVZNVWZiWmVlQUlVcnl1YTBXN3l5REFLMnQvTUFMSzQ0Q3Qy?=
 =?utf-8?B?bVFWeDZnUGxJK05CRm9KV3FIYUx5NmQ4N2RVbjhsd1gxdTZpZ1VWekdzU2xq?=
 =?utf-8?B?S0hXRDBFazFBVE96REs0SDZOSTkrNDhvS0J0S2ZWNll4alkxekpkTFh4Nk9q?=
 =?utf-8?B?WUI0UTFZOU44SkNNdEg1OGNIRlZmVlRpWnpuQmhXdGtMKzFDUkpDUm1rM0Rt?=
 =?utf-8?B?cmJNdHA2YUd4U1BhOXJqeTlHVUNUTEhWZWtEVm9BZkVBRWtZSmd5d1dBKzBr?=
 =?utf-8?B?Qll0TG5YUUlkb1Y0dE9PNGp1VjA4VW44U2gwNkJMaWZrUWhHMWNyUFJieUEw?=
 =?utf-8?B?YUJxd3dWVndpRFpXUEtHRm9TSDRVbUVhbDNpeDBvZXF4NW1Fa09taGR3TW1w?=
 =?utf-8?B?MGp2dWMvR1E0Z1FOSlMrVFZRRkQxOFNNbXFXZTRKa0lGQ2RvWmVPSlZMMjBq?=
 =?utf-8?Q?u+BnPLRoa+hyvLOV/sf+H9Rb8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzRENWJRcDUxVFgvS2NScEtGQjBHdFFrWjR4d2tybXROQ2dHeHEwaEVYRGla?=
 =?utf-8?B?L1VaUXhkZnFjYmw5eFFYZzBCbDNXM0N1M0NYVnljMjJyY3ZpdEI2amFwUWY1?=
 =?utf-8?B?R3ZVb0N5dENlS1U0U2l2QkxsOHFzdWd6L1lXN2FudTRsOXZyc1Mwb3FYNk5p?=
 =?utf-8?B?MXlxOUJ5SWJReFdvcmVCTFRuVTdtRXdaWUozejd2OGFSeDloZlltNlltNVdG?=
 =?utf-8?B?a3pNRzg1UnNucFUxVXUra3MvdEYxVU9xdlQrZHJBY1N3V29JLytLdXFZc2dV?=
 =?utf-8?B?UldwLzUvcHU5cHppcUNGSktXOEhTbWEvUWZBdXJlQjY3L0dmS3dwRzQvVlZW?=
 =?utf-8?B?dzFiTHRXcWJQMjhuMk9GeWllOTJVa0JDN2ZlUWVZNWNoVkFIMmptM1FGaDla?=
 =?utf-8?B?UUlqRE05THZUaFN5QUhkODVIZFY4UTJicDh1UzJ3QUJFcTNISnFjMFJnUTBi?=
 =?utf-8?B?bFhDLzYyTStLZXRWcFpOMHVJaThKbkxXd1lmSWt2WGtGZ2toMXJSOEpXQVU3?=
 =?utf-8?B?cVQ1K24xblZvelNONlpYLzBNb2FYTnNHUUphekNPQ2trNlJhWVpFZktNVktk?=
 =?utf-8?B?RFhSa0cvaytHdWdWRWdoRSsvT2lNWm9CNVhBVkFaMkFGbmlkRG1MbFZqZ1VK?=
 =?utf-8?B?ZmNuR3hpOUY3Rk1ISEE0TEF5bU1GdGxmbnovUHNUQXc4VE5XN3hUZURtWEI0?=
 =?utf-8?B?L2I2bEczLzY4UFUvY3VLNldPN3FyK1NlNHBnSXg4cEZjYzlLYUFIQUVoQnpm?=
 =?utf-8?B?djhPcVZ3dWs1MlAyaFYwd0szUHBHN2tvb0IxR1FGZ0JtNElJMGJvTGFHTzNt?=
 =?utf-8?B?QzFTVWdZUWZ6UlFIVWg3cGlJN1pmMWlOSktQUSsyNlN2aTdmYTZSbTUvcm93?=
 =?utf-8?B?VndxRFdXS2h4c3hCOXlPcXlkMzJXTmorb0VJdUpyK014cDU0MzEyY2VKWnp4?=
 =?utf-8?B?ZkpPbWZWUDd1Tmswa1I2VUtGSU9rdTQ5OW55cGZjeXF4eW9GK3Rtd2tMQ0wv?=
 =?utf-8?B?YnBtcnRVektmOFVraWRwcjNBL1RQM3hidC92bWh1cTJmOStGZW5xS0xIbEhm?=
 =?utf-8?B?blVKOU5kSWI2YmJ2K080NmIyOXNhektJNXR5dGUvS1dNcERWT21YZTFLTlVB?=
 =?utf-8?B?aWhVZnovY05yUlEzY1hlcHJDbWRwRFJZdk05cUQ2aDRHUDNxQUhBeHYrN2t6?=
 =?utf-8?B?RytUUGdaeXNEKzNOQTNsZEkzVkthaUpCQlVBenMzYmZuNGNTZy9VTXpVWlAv?=
 =?utf-8?B?Z1lMRnhWdUs2MnQrYUN2RCsyMDc2WWxLVWlud2xSTXU5Q1hsdVJTaTMvMFhZ?=
 =?utf-8?B?dTErUy8ycHRwemRGSFpCZG91endVbUExdDhTb2NWb002d1ZvcG5PUXhLRE5I?=
 =?utf-8?B?RGxnRXl6NEI1T0hpSkJpelluRGZVcTBpSW5lNng3ckhTR1dwRTVjNkl2V2Er?=
 =?utf-8?B?VmFOMlJlSnZqbURYUmZJT21GdzU3c01jZkZCSDZ6U3doUnEwSGNsdFhBWnRo?=
 =?utf-8?B?eEFNZ1hMRmNsSGlNYnBmVk14amd2SXNIeUJzOHBURDNRclVyc1NpbENoekNp?=
 =?utf-8?B?elRycXoxWEFzKzJIRmFvRHdLZ0crbU9kSGxhZjczSEt2QUpHSjNSSXdGemJu?=
 =?utf-8?B?a0ZWSmI0NWIreGtkRkgreWNBak9GRnVEQzFNYTk3cURTMFFyR2x2dnc0Ryt4?=
 =?utf-8?Q?kcRsVB4OSyhcCdHBMgkE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef500a38-29be-4917-d21d-08de0431b456
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 17:07:46.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6464

Hi Krzysztof, Rob,

Since I have to submit another version anyways, I was thinking of
changing from a fallback compatible to a list of enums but wanted to get
your guidance on this. The driver needs not distinguish between the SoCs
and no SoC specific match data is needed. Would you prefer as proposed
in below patch or switch to enumerating them in the bindings and in the
driver?

On 10/1/25 18:04, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The IPQ5018 SoC contains a PWM block which is exactly the same as the
> one found in IPQ6018. So let's add a compatible for IPQ5018 and use
> IPQ6018 as the fallback.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> index 1172f0b53fadc140482f9384a36020260df372b7..acbdd952fcca53368e3b594544df8d3dae8a06b3 100644
> --- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> @@ -11,7 +11,12 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: qcom,ipq6018-pwm
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,ipq5018-pwm
> +          - const: qcom,ipq6018-pwm
> +      - const: qcom,ipq6018-pwm
>  
>    reg:
>      maxItems: 1
> 

Best regards,
George

